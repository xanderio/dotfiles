{ config, ... }: {
  services = {
    nginx.virtualHosts."paper.xanderio.de" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyWebsockets = true;
        proxyPass = "http://[fd7a:115c:a1e0:ab12:4843:cd96:626e:4b10]:${toString config.services.paperless.port}/";
      };
      extraConfig = ''
        client_max_body_size 1G;
      '';
    };
  };
}
