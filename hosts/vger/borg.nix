{ ... }:
{
  services.borgbackup.jobs = {
    backup = {
      paths = [
        "/etc"
        "/home"
      ];
      exclude = [
        "/nix"
        "'**/.cache'"
        "**/target"
        "**/.cache"
        "/home/xanderio/Sources"
      ];
      repo = "u289342@u289342.your-storagebox.de:backup/vger";
      encryption = {
        mode = "repokey-blake2";
        passCommand = "cat /var/borg/passphrase";
      };
      environment = {
        BORG_RSH = "ssh -p 23 -i /var/borg/id_ed25519";
      };
      compression = "auto,zstd,10";
      startAt = "*-*-* 17:00:00";
      persistentTimer = true;
    };
  };
}
