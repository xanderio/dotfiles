{ pkgs, config, ... }:
let 
  mealie-update = builtins.getFlake "github:xanderio/nixpkgs/2f221dafebecde8ac3c98cb1616976c55cc300eb";
in
{
  config = {
    services.postgresql = {
      enable = true;
      ensureUsers = [
        {
          name = "mealie";
          ensureDBOwnership = true;
        }
      ];
      ensureDatabases = [ "mealie" ];
    };

    services.nginx = {
      enable = true;
      virtualHosts."mealie.blatory.de" = {
        enableACME = true;
        forceSSL = true;
        locations = {
          "/" = {
            proxyPass = "http://localhost:${toString config.services.mealie.port}";
            extraConfig = ''
              client_max_body_size 500m;
            '';
          };
        };
      };
    };

    x.sops.secrets."services/mealie/oidc_secret" = { };
    sops.templates."mealie-env" = {
      content = ''
        OIDC_CLIENT_SECRET = ${config.sops.placeholder."services/mealie/oidc_secret"}

      '';
    };

    services.mealie = {
      enable = true;
      package = mealie-update.legacyPackages.${pkgs.system}.mealie;
      credentialsFile = config.sops.templates."mealie-env".path;
      listenAddress = "[::]";
      port = 9003;
      settings = {
        DB_ENGINE = "postgres";
        POSTGRES_URL_OVERRIDE = "postgresql://mealie:@/mealie?host=/run/postgresql";
        OIDC_AUTH_ENABLED = true;
        OIDC_CONFIGURATION_URL = "https://sso.xanderio.de/application/o/mealie/.well-known/openid-configuration";
        OIDC_AUTO_REDIRECT = true;
        OIDC_CLIENT_ID = "mealie";
        OIDC_ADMIN_GROUP = "mealie-admin";
        OIDC_PROVIDER_NAME = "Authentik";
        OIDC_REMEMBER_ME = true;
      };
    };
  };
}
