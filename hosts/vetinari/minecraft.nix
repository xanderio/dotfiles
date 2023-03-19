{ pkgs, ... }: {

  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.modded-minecraft-servers = {
    eula = true;

    instances = {
      thevault3 = {
        enable = false;

        rsyncSSHKeys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJDvsq3ecdR4xigCpOQVfmWZYY74KnNJIJ5Fo0FsZMGW asieg@GLaDOS"
        ];

        serverConfig = {
          server-port = 25566;
          motd = "Welcome to Vault Hunter 3";
        };
      };
    };
  };


  services.borgbackup.jobs.backup.paths = [ "/srv/minecraft" ];
  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    servers.minecraft = {
      enable = true;
      package = pkgs.minecraftServers.fabric-1_19;
      serverProperties = {
        server-port = 25565;
        difficulty = 3;
        max-players = 10;
        white-list = true;
        spawn-protection = 0;
      };
      whitelist = {
        "xanderio" = "40470409-787b-494a-ada2-49f097e7cf50";
        "MrKrisKrisu" = "09ad39cf-b231-4d2f-8efd-8deb1ebf52ab";
        "gim___" = "cac5d597-cd9a-43a4-9738-1f833b769ced";
        "telegnom" = "7767ea2a-4c84-4fec-a165-37161ecdf428";
        "zoneoftroll" = "2efb4d0b-6270-4038-8f01-4efa7ce7922c";
        "xScrillexx" = "cf666d0d-524f-4c17-8989-b1fe317bb5dd";
      };
      symlinks = {
        mods =
          pkgs.linkFarmFromDrvs "mods" (map pkgs.fetchurl ([
            {
              url = "https://github.com/gnembon/fabric-carpet/releases/download/1.4.79/fabric-carpet-1.19-1.4.79+v220607.jar";
              sha256 = "0110xxxs17n17fb5d216fgycz458anvjkcqj9pr70ffy36d3qirx";
            }
            {
              url = "https://github.com/gnembon/carpet-extra/releases/download/1.4.79/carpet-extra-1.19-1.4.79.jar";
              sha256 = "05wakimih6b93pw0cmswj1glrrnjad754nzycz2w82idk9dy67lw";
            }
            {
              url = "https://github.com/MisterPeModder/ShulkerBoxTooltip/releases/download/v3.0.9%2B1.19/shulkerboxtooltip-3.0.9+1.19.jar";
              sha256 = "1f8a96177wfp71h052104qkz6ksgq0ql5gbssv78sdiz6cwg67z1";
            }
            { url = "https://cdn.modrinth.com/data/9s6osm5g/versions/7.0.72%2Bfabric/cloth-config-7.0.72-fabric.jar"; sha512 = "d16637c1fb138ec018a7c3234b015269208569bf51a6e5fa8f283321efb352d5793e05185dc1be066ae0d5034fd4f69e4cce1961c09ee75e2d641c5a907533db"; }
            { url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/0.56.3%2B1.19/fabric-api-0.56.3%2B1.19.jar"; sha512 = "5647a3787964e6228440189c7818d2f0596f99bcc7c673ce1283ed4bb2dcaac707f769bab6875543ab3d059b5d7e4aa88978a688ce08e801902806e92ace7a1d"; }
            { url = "https://cdn.modrinth.com/data/wwcspvkr/versions/2.4.0-1.19/textile_backup-2.4.0-1.19.jar"; sha512 = "ec9a327ffa01023b1ef7b452f902b979e8e6872102aa69ee58b8b942c89cae42a030881d88977f62493ce12d6a652254ff42c02a70f4288ed3c2ab4a770104c6"; }
            { url = "https://cdn.modrinth.com/data/H8CaAYZC/versions/1.1.1%2B1.19/starlight-1.1.1%2Bfabric.ae22326.jar"; sha512 = "68f81298c35eaaef9ad5999033b8caf886f3c583ae1edc25793bdd8c2cbf5dce6549aa8d969c55796bd8b0d411ea8df2cd0aaeb9f43adf0691776f97cebe1f9f"; }
            { url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/mc1.19-0.8.0/lithium-fabric-mc1.19-0.8.0.jar"; sha512 = "3c8d88f8b1a2202d5891879549dd58de27f12a3a7bdb66083b6fde3c08256807515fd81f86fa0c147473640e8087ae5e12a20fe22c9b5eb8d830842b3512687d"; }
            { url = "https://cdn.modrinth.com/data/uXXizFIs/versions/5.0.0-fabric/ferritecore-5.0.0-fabric.jar"; sha512 = "ea54167b9c054a7e486dc01113ee9fc6d3ed0e527cb2fe238f7f5ba5823ac18f4e7c70bf89d14c9845485ca881b757b7672cda610c7fac580fd55db7070d02b4"; }
          ]
          )
          );
      };
    };
  };
}
