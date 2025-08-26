{
  config = {
    networking.firewall = {
      allowedTCPPorts = [
        #mqtt
        1883
        10200
        10300
        10400
      ];
      allowedUDPPorts = [ 5353 ];
    };

    services.nginx = {
      enable = true;
      proxyResolveWhileRunning = true;
      resolver.addresses = [
        "127.0.0.53:53"
      ];
      upstreams."hass".servers = {
        "homeassistant.local:8123" = { };
      };
      virtualHosts."hass.blatory.de" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://hass";
          proxyWebsockets = true;
        };
      };
    };

    services.mosquitto = {
      enable = false;
      settings = {
        sys_interval = 10;
      };
      listeners = [
        {
          acl = [
            "pattern readwrite #"
            "pattern readwrite $SYS/#"
          ];
          omitPasswordAuth = true;

          settings.allow_anonymous = true;
        }
      ];
    };

    systemd.services."wyoming-faster-whisper-home-assistant".serviceConfig.PrivateTmp = true;
    services.wyoming = {
      faster-whisper.servers."home-assistant" = {
        enable = true;
        model = "turbo";
        language = "de";
        uri = "tcp://0.0.0.0:10300";
      };

      piper.servers."home-assistant" = {
        enable = true;
        voice = "de_DE-thorsten-high";
        uri = "tcp://0.0.0.0:10200";
      };

      openwakeword = {
        enable = true;
        preloadModels = [ "ok_nabu" ];
        uri = "tcp://0.0.0.0:10400";
      };
    };
  };
}
