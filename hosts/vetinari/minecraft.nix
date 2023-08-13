{ pkgs, ... }: let 
  rsyncSSHKeys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJDvsq3ecdR4xigCpOQVfmWZYY74KnNJIJ5Fo0FsZMGW asieg@GLaDOS"
  ];
in{
  services.modded-minecraft-servers = {
    eula = true;

    instances = {
      vanilla = {
        enable = false;
        inherit rsyncSSHKeys;
        jvmPackage = pkgs.jdk17;
        jvmMaxAllocation = "1G";
        serverConfig = {
          server-port = 25565;
          motd = "Welcome to Vanilla";
        };
      };
      thevault3 = {
        enable = false;

        inherit rsyncSSHKeys;

        serverConfig = {
          server-port = 25566;
          motd = "Welcome to Vault Hunter 3";
        };
      };
    };
  };

  services.borgbackup.jobs.backup.paths = [ "/var/lib/mc-vanilla" ];
}
