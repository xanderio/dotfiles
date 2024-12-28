{ config, ... }:
{
  config = {
    services.immich = {
      enable = true;
    };

    services.nginx = {
      enable = true;
      virtualHosts."immich.xanderio.de" = {
        enableACME = true;
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://${config.services.immich.host}:${toString config.services.immich.port}";
          proxyWebsockets = true;
          extraConfig = ''
            client_max_body_size 0;
          '';
        };
      };
    };
  };
}
