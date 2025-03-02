{
  config,
  lib,
  pkgs,
  ...
}:
{
  x.sops.secrets = {
    "all/borg_backup/ssh_key".owner = "root";
    "all/borg_backup/repo_key".owner = "root";
  };
  services.borgbackup.jobs =
    let
      commonOptions = {
        exclude = [ "'**/.cache'" ];
        repo = "u289342@u289342.your-storagebox.de:backup/${config.networking.hostName}";
        encryption = {
          mode = "repokey-blake2";
          passCommand = "cat ${config.sops.secrets."all/borg_backup/repo_key".path}";
        };
        environment = {
          BORG_RSH = "ssh -p 23 -o 'StrictHostKeyChecking=no' -i ${
            config.sops.secrets."all/borg_backup/ssh_key".path
          }";
        };
        compression = "auto,zstd,10";
        prune.keep = {
          within = "1d"; # Keep all archives from the last day
          daily = 7;
          weekly = 4;
          monthly = 1;
        };
        extraCreateArgs = "--verbose --exclude-caches --stats --checkpoint-interval 600";
        startAt = "hourly";
      };
    in
    {
      backup = {
        paths = [
          "/var/lib/nextcloud"
          "/var/lib/immich"
          "/var/lib/audiobookshelf"
          "/home"
          "/root"
        ];
      } // commonOptions;
    }
    // {
      paperless = {
        preHook = "/run/current-system/sw/bin/paperless-manage document_exporter --no-progress-bar /var/lib/paperless/export";
        readWritePaths = ["/var/lib/paperless"];
        paths = [
          "/var/lib/paperless/export"
        ];
      } // commonOptions;
    }
    // (lib.listToAttrs (
      map (
        name:
        lib.nameValuePair "psql-${name}" ({
          dumpCommand = pkgs.writeShellScript "psql-backup-${name}" "${pkgs.sudo}/bin/sudo -u postgres ${config.services.postgresql.package}/bin/pg_dump -Cc -d ${name}";
        }
        // commonOptions)
      ) (config.services.postgresql.ensureDatabases)
    ));
}
