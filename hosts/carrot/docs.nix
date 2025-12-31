{ config, pkgs, ... }:
{
  config = {
    x.sops.secrets."services/docs/s3/access" = { };
    x.sops.secrets."services/docs/s3/secret" = { };
    x.sops.secrets."services/docs/oidc/secret" = { };
    sops.templates."docs-env" = {
      content = ''
        AWS_S3_ACCESS_KEY_ID=${config.sops.placeholder."services/docs/s3/access"}
        AWS_S3_SECRET_ACCESS_KEY=${config.sops.placeholder."services/docs/s3/secret"}
        OIDC_RP_CLIENT_SECRET=${config.sops.placeholder."services/docs/oidc/secret"}
      '';
    };

    services.lasuite-docs = {
      enable = true;
      domain = "docs.xanderio.de";
      environmentFile = config.sops.templates."docs-env".path;
      s3Url = "https://s3.xanderio.de/docs-media-storage";
      settings = {
        AWS_S3_ENDPOINT_URL = "https://s3.xanderio.de";
        AWS_S3_REGION_NAME = "garage";
        AWS_STORAGE_BUCKET_NAME = "docs-media-storage";

        OIDC_OP_AUTHORIZATION_ENDPOINT = "https://sso.xanderio.de/application/o/authorize/";
        OIDC_OP_JWKS_ENDPOINT = "https://sso.xanderio.de/application/o/docs/jwks/";
        OIDC_OP_LOGOUT_ENDPOINT = "https://sso.xanderio.de/application/o/docs/end-session/";
        OIDC_OP_TOKEN_ENDPOINT = "https://sso.xanderio.de/application/o/token/";
        OIDC_OP_USER_ENDPOINT = "https://sso.xanderio.de/application/o/userinfo/";
        OIDC_RP_CLIENT_ID = "docs";
        OIDC_CREATE_USER = true;

        LOGIN_REDIRECT_URL = "https://docs.xanderio.de";
      };
      postgresql.createLocally = true;
      redis.createLocally = true;
    };

    services.nginx.virtualHosts."docs.xanderio.de" = {
      enableACME = true;
      forceSSL = true;
      locations."/static".root = "${pkgs.lasuite-docs}/share";
    };
  };
}
