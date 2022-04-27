{
  pkgs,
  config,
  ...
}: {
  services = {
    paperless = {
      enable = true;
      package = pkgs.paperless-ngx;
      dataDir = "/mnt/paperless";
      extraConfig = {
        PAPERLESS_OCR_LANGUAGE = "deu";
      };
    };

    nginx.virtualHosts."paper.xanderio.de" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyWebsockets = true;
        proxyPass = "http://localhost:${toString config.services.paperless.port}/";
      };
      extraConfig = ''
        client_max_body_size 1G;
      '';
    };
  };
}
