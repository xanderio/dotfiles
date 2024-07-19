{ config, pkgs, ... }:
let
  outline = pkgs.outline.overrideAttrs rec {
    version = "0.78.0";
    src = pkgs.fetchFromGitHub {
      owner = "outline";
      repo = "outline";
      rev = "v${version}";
      hash = "sha256-I0ngEJfHWywJSYOloJbtuKzu95yJibo7hLFgkyT2Wz8=";
    };
    yarnOfflineCache = pkgs.fetchYarnDeps {
      yarnLock = "${src}/yarn.lock";
      hash = "sha256-TKAV49VJmR/SWTd2T2vHMnYq2j9fwimzYq1CCfRXk0Q=";
    };
  };

in
{
  config = {
    x.sops.secrets."services/outline/oidc-client-secret" = {
      owner = config.services.outline.user;
      inherit (config.services.outline) group;
    };

    x.sops.secrets."services/outline/mailPwd" = {
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
      package = outline;
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
        scopes = [
          "openid"
          "profile"
          "email"
        ];
      };

      smtp = {
        host = "mail.xanderio.de";
        port = 465;
        username = "outline";
        passwordFile = config.sops.secrets."services/outline/mailPwd".path;
        fromEmail = "Outline <outline@xanderio.de>";
        replyEmail = "noreply@xanderio.de";
        secure = true;
      };

      # nginx already handels this
      forceHttps = false;
    };
  };
}
