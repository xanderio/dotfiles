{
  pkgs,
  config,
  lib,
  ...
}:
{
  services = {
    paperless = {
      enable = true;
      package = pkgs.paperless-ngx;
      address = "[::]";
      settings = {
        PAPERLESS_URL = "https://paper.xanderio.de";
        PAPERLESS_OCR_LANGUAGE = "deu";

        PAPERLESS_APPS = "allauth.socialaccount.providers.openid_connect";
      };
    };

    nginx.virtualHosts."paper.xanderio.de" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyWebsockets = true;
        proxyPass = "http://${config.services.paperless.address}:${toString config.services.paperless.port}";
      };
      extraConfig = ''
        client_max_body_size 1G;
      '';
    };
  };

  x.sops.secrets = {
    "services/paperless/oidc_secret" = { };
  };

  sops.templates."paperless-socialaccount-providers" = {
    owner = "paperless";
    content = builtins.toJSON {
      openid_connect = {
        OAUTH_PKCE_ENABLED = "True";
        APPS = [
          {
            provider_id = "authentik";
            name = "Authentik";
            client_id = "paperless";
            secret = config.sops.placeholder."services/paperless/oidc_secret";
            settings.server_url = "https://sso.xanderio.de/application/o/paperless/.well-known/openid-configuration";
          }
        ];
      };
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
    script = lib.mkBefore ''
      export PAPERLESS_SOCIALACCOUNT_PROVIDERS=$(< ${
        config.sops.templates."paperless-socialaccount-providers".path
      })
    '';
  };
  systemd.services.paperless-task-queue = {
    serviceConfig = {
      EnvironmentFile = "${config.services.paperless.dataDir}/secret-key";
      UMask = lib.mkForce "0022";
      ProtectControlGroups = lib.mkForce false;
    };
  };
}
