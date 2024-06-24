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
      virtualHosts."hass.xanderio.de" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://home-assistant.incus.home.xanderio.de:8123";
          proxyWebsockets = true;
        };
      };
    };

    services.mosquitto = {
      enable = true;
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
