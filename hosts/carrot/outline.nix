{ config, ... }:
{
  config = {
    x.sops.secrets."services/outline/oidc-client-secret" = {
      owner = config.services.outline.user;
      inherit (config.services.outline) group;
    };

    services.nginx = {
      enable = true;
      virtualHosts."outline.xanderio.de" = {
        forceSSL = true;
        enableACME = true;
        kTLS = true;
        locations."/" = {
          proxyPass = "http://localhost:${toString config.services.outline.port}";
          recommendedProxySettings = true;
          proxyWebsockets = true;
        };
      };
    };

    services.outline = {
      enable = true;
      port = 9021;
      publicUrl = "https://outline.xanderio.de";
      storage = {
        storageType = "local";
      };

      oidcAuthentication = {
        clientId = "outline";
        clientSecretFile = config.sops.secrets."services/outline/oidc-client-secret".path;
        authUrl = "https://sso.xanderio.de/application/o/authorize/";
        tokenUrl = "https://sso.xanderio.de/application/o/token/";
        userinfoUrl = "https://sso.xanderio.de/application/o/userinfo/";
        displayName = "xanderio SSO";
        scopes = [ "openid" "profile" "email" ];
      };

      # nginx already handels this
      forceHttps = false;
    };
  };
}
