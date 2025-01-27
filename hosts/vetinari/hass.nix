{
  config = {
    networking.firewall = {
      allowedTCPPorts = [
        #mqtt
        1883
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
  };
}
