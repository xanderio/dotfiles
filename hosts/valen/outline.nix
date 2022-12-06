{ config, ... }:
{
  age.secrets."outline" = {
    file = ../../secrets/outline.age;
    owner = config.services.outline.user;
    group = config.services.outline.group;
  };

  age.secrets."outline-bucket-secretKey" = {
    file = ../../secrets/outline-bucket-secretKey.age;
    owner = config.services.outline.user;
    group = config.services.outline.group;
  };

  age.secrets."outline-oidc-secretKey" = {
    file = ../../secrets/outline-oidc-secretKey.age;
    owner = config.services.outline.user;
    group = config.services.outline.group;
  };

  services.nginx = {
    enable = true;
    virtualHosts."outline.xanderio.de" = {
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://localhost:${toString config.services.outline.port}";
        proxyWebsockets = true;
      };
    };
  };

  services.minio = {
    enable = true;
  };

  services.outline = {
    enable = true;
    port = 9080;
    publicUrl = "https://outline.xanderio.de";
    storage = {
      accessKey = "wPUCUSZ8wbMvkyDE";
      secretKeyFile = config.age.secrets."outline-bucket-secretKey".path;
      uploadBucketUrl = "http://localhost:9000";
      uploadBucketName = "outline";
      region = "de";
    };

    oidcAuthentication = {
      clientId = "7V7QZGIApyPuyBjs1AUJxjDZdmrE2Jc3uMuxvEC66X6vFY0cQ28guiWTHkOIg0EL";
      clientSecretFile = config.age.secrets."outline-oidc-secretKey".path;
      authUrl = "https://cloud.xanderio.de/index.php/apps/oidc/authorize";
      tokenUrl = "https://cloud.xanderio.de/index.php/apps/oidc/token";
      userinfoUrl = "https://cloud.xanderio.de/index.php/apps/oidc/userinfo";
    };
  };
}
