{ pkgs, ... }:
{
  config = {
    networking.firewall = {
      allowedTCPPorts = [
        # airplay 1 
        3689
        5000
        # airplay 2
        7000
      ];
      allowedUDPPorts = [
        # AirPlay 2
        319
        320
      ];
      allowedTCPPortRanges = [
        # AirPlay 2 
        {
          from = 32768;
          to = 60999;
        }
      ];
      allowedUDPPortRanges = [
        # AirPlay 1
        {
          from = 6000;
          to = 6009;
        }

        # AirPlay 2
        {
          from = 32768;
          to = 60999;
        }
      ];
    };

    services.avahi = {
      enable = true;
      publish = {
        enable = true;
        userServices = true;
      };
    };

    systemd.targets.aerosound = {
      description = "Common target for all Aerosound services.";
      wantedBy = [ "multi-user.target" ];
    };

    systemd.services.nqptp = {
      wantedBy = [ "aerosound.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.nqptp}/bin/nqptp";
        Restart = "always";
        RestartSec = 10;
      };
    };

    systemd.services.shairport-sync = {
      wantedBy = [ "aerosound.target" ];
      wants = [ "avahi-daemon.service" ];
      requires = [
        "nqptp.service"
        "mosquitto.service"
        "pipewire.service"
      ];
      after = [
        "network-online.target"
        "avahi-daemon.service"
        "nqptp.service"
        "pipewire.service"
      ];

      serviceConfig =
        let
          shairport =
            (pkgs.shairport-sync.override {
              enableMetadata = true;
              enableAirplay2 = true;
            }).overrideAttrs
              (old: {
                configureFlags = old.configureFlags ++ [ "--with-mqtt-client" ];
                buildInputs = old.buildInputs ++ [
                  pkgs.mosquitto.lib
                  pkgs.mosquitto.dev
                ];
              });

          shairportConfigFile = pkgs.writeText "shairport.conf" ''
            general = {
            	name = "Vetinari";
            	output_backend = "pw";
            	mdns_backend = "avahi";
            };

            metadata = {
            	enabled = "yes"; // set this to yes to get Shairport Sync to solicit metadata from the source and to pass it on via a pipe
            	include_cover_art = "yes"; // set to "yes" to get Shairport Sync to solicit cover art from the source and pass it via the pipe. You must also set "enabled" to "yes".
            	cover_art_cache_directory = "/tmp/shairport-sync/.cache/coverart"; // artwork will be  stored in this directory if the dbus or MPRIS interfaces are enabled or if the MQTT client is in use. Set it to "" to prevent caching, which may be useful on some systems
            	pipe_name = "/tmp/shairport-sync-metadata";
            	pipe_timeout = 5000; // wait for this number of milliseconds for a blocked pipe to unblock before giving up
            };

            pw = {
            	application_name = "Shairport Sync"; // Set this to the name that should appear in the Sounds "Applications" or "Volume Levels".
            	node_name = "Shairport Sync"; // This appears in some PipeWire CLI tool outputs.
            //	sink_target = "<sink target name>"; // Leave this commented out to get the sink target already chosen by the PipeWire system.
            };

            mqtt = {
            	enabled = "yes"; // set this to yes to enable the mqtt-metadata-service
            	hostname = "192.168.178.33"; // Hostname of the MQTT Broker
            	port = 1883; // Port on the MQTT Broker to connect to
            	username = ""; //set this to a string to your username in order to enable username authentication
            	password = ""; //set this to a string you your password in order to enable username & password authentication
            	topic = "aerosound/vetinari/shairport"; //MQTT topic where this instance of shairport-sync should publish. If not set, the general.name value is used.
            	publish_parsed = "yes"; //whether to publish a small (but useful) subset of metadata under human-understandable topics
            	publish_cover = "yes"; //whether to publish the cover over mqtt in binary form. This may lead to a bit of load on the broker
            	enable_remote = "yes"; //whether to remote control via MQTT. RC is available under `topic`/remote.
            };
          '';
        in
        {
          ExecStart = "${shairport}/bin/shairport-sync -c ${shairportConfigFile}";
          Restart = "always";
          RestartSec = 10;
        };
    };
  };
}
