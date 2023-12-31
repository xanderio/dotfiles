{ pkgs, config, lib, ... }: {
  services = {
    paperless = {
      enable = true;
      package = pkgs.paperless-ngx;
      address = "[::]";
      extraConfig = {
        PAPERLESS_URL = "https://paper.xanderio.de";
        PAPERLESS_OCR_LANGUAGE = "deu";

        PAPERLESS_ENABLE_HTTP_REMOTE_USER = true;
        PAPERLESS_HTTP_REMOTE_USER_HEADER_NAME = "HTTP_X_AUTHENTIK_USERNAME";
      };
    };

    authentik-proxy = {
      enable = true;
      domains = [ "paper.xanderio.de" ];
    };

    nginx.virtualHosts."paper.xanderio.de" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyWebsockets = true;
        proxyPass = "http://${config.services.paperless.address}:${toString config.services.paperless.port}/";
      };
      extraConfig = ''
        client_max_body_size 1G;
      '';
    };
  };

  systemd.services.paperless-scheduler = {
    serviceConfig = {
      EnvironmentFile = "${config.services.paperless.dataDir}/secret-key";
      UMask = lib.mkForce "0022";
      ProtectControlGroups = lib.mkForce false;
    };
  };
  systemd.services.paperless-consumer = {
    serviceConfig = {
      EnvironmentFile = "${config.services.paperless.dataDir}/secret-key";
      UMask = lib.mkForce "0022";
      ProtectControlGroups = lib.mkForce false;
    };
  };
  systemd.services.paperless-web = {
    serviceConfig = {
      EnvironmentFile = "${config.services.paperless.dataDir}/secret-key";
      UMask = lib.mkForce "0022";
      ProtectControlGroups = lib.mkForce false;
    };
  };
  systemd.services.paperless-task-queue = {
    serviceConfig = {
      EnvironmentFile = "${config.services.paperless.dataDir}/secret-key";
      UMask = lib.mkForce "0022";
      ProtectControlGroups = lib.mkForce false;
    };
  };
}
