{ config, lib, ... }:
{
  config = {
    x.sops.secrets."services/miniflux/env" = { };

    services.miniflux = {
      enable = true;
      adminCredentialsFile = config.sops.secrets."services/miniflux/env".path;
      config = {
        LOG_LEVEL = "debug";
        CREATE_ADMIN = lib.mkForce false;
        FETCH_YOUTUBE_WATCH_TIME = "1";
        FETCH_ODYSEE_WATCH_TIME = "1";
        CLEANUP_REMOVE_SESSIONS_DAYS = "120";
        OAUTH2_PROVIDER = "oidc";
        OAUTH2_CLIENT_ID = "miniflux";
        OAUTH2_REDIRECT_URL = "https://miniflux.xanderio.de/oauth2/oidc/callback";
        OAUTH2_OIDC_DISCOVERY_ENDPOINT = "https://sso.xanderio.de/application/o/miniflux/";
        OAUTH2_USER_CREATION = "1";
      };
    };
    services.nginx = {
      enable = true;
      virtualHosts = {
        "miniflux.xanderio.de" = {
          enableACME = true;
          forceSSL = true;
          locations."/" = {
            proxyPass = "http://localhost:8080/";
          };
        };
      };
    };
  };
}
