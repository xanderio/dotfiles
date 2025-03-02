{
  config,
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
          "/var/lib/"
          "/home"
          "/root"
        ];
      } // commonOptions;
    };
}
