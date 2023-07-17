{ pkgs, config, ... }: {
  services = {
    paperless = {
      enable = true;
      package = pkgs.paperless-ngx;
      address = "[::]";
      extraConfig = {
        PAPERLESS_URL = "https://paper.xanderio.de";
        PAPERLESS_OCR_LANGUAGE = "deu";
      };
    };
  };

  systemd.services.paperless-scheduler = {
    serviceConfig.EnviromentFile = "${config.services.paperless.dataDir}/secret-key";
  };
  systemd.services.paperless-consumer = {
    serviceConfig.EnviromentFile = "${config.services.paperless.dataDir}/secret-key";
  };
  systemd.services.paperless-web = {
    serviceConfig.EnviromentFile = "${config.services.paperless.dataDir}/secret-key";
  };
}
