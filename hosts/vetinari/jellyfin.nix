{
  config = {
    services.nginx = {
      enable = true;
      virtualHosts."media.xanderio.de" = {
        enableACME = true;
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://localhost:8096";
          proxyWebsockets = true;
        };
        extraConfig = ''
          client_max_body_size 5G;
        '';
      };
    };

    services.jellyfin.enable = true;
  };
}
