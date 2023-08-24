{ pkgs, config, lib, ... }: {
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
    serviceConfig = {
      EnvironmentFile = "${config.services.paperless.dataDir}/secret-key";
      UMask = lib.mkForce "0022";
    };
  };
  systemd.services.paperless-consumer = {
    serviceConfig = {
      EnvironmentFile = "${config.services.paperless.dataDir}/secret-key";
      UMask = lib.mkForce "0022";
    };
  };
  systemd.services.paperless-web = {
    serviceConfig = {
      EnvironmentFile = "${config.services.paperless.dataDir}/secret-key";
      UMask = lib.mkForce "0022";
    };
  };
  systemd.services.paperless-task-queue = {
    serviceConfig = {
      EnvironmentFile = "${config.services.paperless.dataDir}/secret-key";
      UMask = lib.mkForce "0022";
    };
  };
}
