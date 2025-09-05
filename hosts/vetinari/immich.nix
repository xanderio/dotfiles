{ config, ... }:
{
  config = {
    x.sops.secrets = {
      "services/immich/restic/password" = {
        owner = config.services.immich.user;
      };
      "services/immich/restic/s3/key_id" = { };
      "services/immich/restic/s3/secret_key" = { };
    };

    sops.templates."immich-restic-env" = {
      owner = config.services.immich.user;
      content = ''
        AWS_ACCESS_KEY_ID = ${config.sops.placeholder."services/immich/restic/s3/key_id"}
        AWS_SECRET_ACCESS_KEY = ${config.sops.placeholder."services/immich/restic/s3/secret_key"}
      '';
    };

    services.immich = {
      enable = true;
    };

    services.nginx = {
      enable = true;
      virtualHosts."immich.xanderio.de" = {
        enableACME = true;
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://${config.services.immich.host}:${toString config.services.immich.port}";
          proxyWebsockets = true;
          extraConfig = ''
            client_max_body_size 0;
          '';
        };
      };
    };

    services.restic.backups."immich" = {
      initialize = true;
      user = config.services.immich.user;
      passwordFile = config.sops.secrets."services/immich/restic/password".path;
      repository = "s3:https://s3.xanderio.de/immich-backup";
      environmentFile = config.sops.templates."immich-restic-env".path;
      paths = [
        config.services.immich.mediaLocation
        "/tmp/immich/backup/"
      ];
      backupPrepareCommand = ''
        mkdir -p /tmp/immich/backup 
        ${config.services.postgresql.package}/bin/pg_dump --create --clean --if-exists immich > /tmp/immich/backup.sql
      '';
      pruneOpts = [
        "--keep-daily 7"
        "--keep-weekly 5"
        "--keep-monthly 12"
      ];
      timerConfig = {
        OnCalendar = "daily";
        RandomizedDelaySec = "5h";
        Persistent = true;
      };
    };
  };
}
