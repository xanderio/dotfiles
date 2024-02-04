#!/usr/bin/env nix-shell
#! nix-shell -i python -p python311 python311Packages.paho-mqtt

import paho.mqtt.publish as publish
import paho.mqtt.subscribe as subscribe
import paho.mqtt.client as mqtt

import json

mqttc = mqtt.Client(protocol=mqtt.MQTTv5)

application_prefix = "shairport"
instance_prefix = "vetinari"

def publish_config(name, component="sensor", payload={}):
    for char in '()': 
        name = name.replace(char, "")
    name = name.replace(' ', "_")

    topic = f"homeassistant/{component}/{application_prefix}_{instance_prefix}_{name}/config"
    payload |= {
        "name": f"{application_prefix} {instance_prefix} {name}",
        "unique_id": f"{application_prefix}_{instance_prefix}_{name}",
        "device": {
            "identifiers": [
                f"{application_prefix}_{instance_prefix}"
            ],
            "name": f"{application_prefix} {instance_prefix}",
            "manufacturer": "Entropia",
            "model": "Aerosound"
        }
        }
    mqttc.publish(topic, payload=json.dumps(payload))

def publish_discovery():
    print("publishing discovery config")

    publish_config("active start", component="binary_sensor", payload={
        "state_topic": f"aerosound/{instance_prefix}/shairport/active_start",
        "payload_on": "--",
        "payload_off": "OFF",
        "off_delay": 300,
        })

    publish_config("active end", component="binary_sensor", payload={
        "state_topic": f"aerosound/{instance_prefix}/shairport/active_end",
        "payload_on": "--",
        "payload_off": "OFF",
        "off_delay": 300,
        })

    for name in ["album", "artist", "title", "genre"]:
        publish_config(name, payload={
            "state_topic": f"aerosound/{instance_prefix}/shairport/{name}"
            })

    publish_config("volume (dB)", payload={
        "state_topic": f"aerosound/{instance_prefix}/shairport/volume"
        })

    publish_config("volume (RCT)", payload={
        "state_topic": f"aerosound/{instance_prefix}/shairport/volume",
        "value_template": "{{ value |  regex_findall_index(find='^(.+?),', index=0, ignorecase=False) | float / 30 + 1  }}",
      "unit_of_measurement": 'percent'
        })

    publish_config("cover", component="image", payload={
        "image_topic": f"aerosound/{instance_prefix}/shairport/cover"
        })
    pass


def on_homeassistant_start(client, userdata, message):
    if message.payload == b'online':
        print("homeassistant has come online")
        publish_discovery()

def on_connect(client, userdata, connect_flags, reason_code, properties):
    print(f"Connected with result code: {mqtt.connack_string(reason_code)}")

    client.subscribe("homeassistant/status")

if __name__ == "__main__":
    mqttc.on_connect = on_connect
    mqttc.message_callback_add("homeassistant/status", on_homeassistant_start)
    mqttc.connect("192.168.178.33")
    publish_discovery()

    mqttc.loop_forever()
