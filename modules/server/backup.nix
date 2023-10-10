{ config, ... }:
{
  sops.secrets.repo_key.sopsFile = ../../secrets/all/borg_backup.yaml;
  age.secrets = {
    "storagebox-sshkey".file = ../../secrets/storagebox-sshkey.age;
    "backup-key".file = ../../secrets/backup-key.age;
  };
  services.borgbackup.jobs = {
    backup = {
      paths = [ "/var/lib" "/home" "/root" ];
      exclude = [ "'**/.cache'" ];
      repo = "u289342@u289342.your-storagebox.de:backup/${config.networking.hostName}";
      encryption = {
        mode = "repokey-blake2";
        passCommand = "cat ${config.age.secrets.backup-key.path}";
      };
      environment = {
        BORG_RSH = "ssh -p 23 -o 'StrictHostKeyChecking=no' -i ${config.age.secrets.storagebox-sshkey.path}";
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
  };
}
