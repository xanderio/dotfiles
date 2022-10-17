{ pkgs
, config
, lib
, ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/woodpecker
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.grub.device = "/dev/sda";

  networking = {
    hostName = "block";
    useDHCP = false;
    enableIPv6 = true;

    interfaces.enp1s0.useDHCP = true;
    interfaces.enp1s0.ipv6.addresses = [
      {
        address = "2a01:4f8:c2c:9da8::1";
        prefixLength = 64;
      }
    ];
    defaultGateway6 = {
      address = "fe80::1";
      interface = "enp1s0";
    };
    nameservers = [ "2a01:4ff:ff00::add:1" "2a01:4ff:ff00::add:2" "185.12.64.1" "185.12.64.2" ];
  };

  services.promtail.configuration = {
    scrape_configs = [
      {
        job_name = "minecraft";
        static_configs = [
          {
            labels = {
              job = "minecraft";
              "__path__" = "/srv/minecraft/*/logs/latest.log";
            };
          }
        ];
      }
    ];
  };

  age.secrets = {
    "hercules-cache" = {
      file = ../../secrets/hercules-cache.age;
      owner = "hercules-ci-agent";
    };
    "hercules-token" = {
      file = ../../secrets/hercules-token.age;
      owner = "hercules-ci-agent";
    };
  };
  services.hercules-ci-agent = {
    enable = true;
    settings = {
      concurrentTasks = 6;
      binaryCachesPath = config.age.secrets.hercules-cache.path;
      clusterJoinTokenPath = config.age.secrets.hercules-token.path;
    };
  };

  services.borgbackup.jobs.backup.paths = [ "/srv/minecraft" ];
  services.minecraft-servers = {
    enable = false;
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
          pkgs.linkFarmFromDrvs "mods"
            ((
              map pkgs.fetchurl (builtins.attrValues {
                Carpet = {
                  url = "https://github.com/gnembon/fabric-carpet/releases/download/1.4.79/fabric-carpet-1.19-1.4.79+v220607.jar";
                  sha256 = "0110xxxs17n17fb5d216fgycz458anvjkcqj9pr70ffy36d3qirx";
                };
                Carpet-Extra = {
                  url = "https://github.com/gnembon/carpet-extra/releases/download/1.4.79/carpet-extra-1.19-1.4.79.jar";
                  sha256 = "05wakimih6b93pw0cmswj1glrrnjad754nzycz2w82idk9dy67lw";
                };
                ShulkerBoxTooltip = {
                  url = "https://github.com/MisterPeModder/ShulkerBoxTooltip/releases/download/v3.0.9%2B1.19/shulkerboxtooltip-3.0.9+1.19.jar";
                  sha256 = "1f8a96177wfp71h052104qkz6ksgq0ql5gbssv78sdiz6cwg67z1";
                };
              })
            )
            ++ (map pkgs.fetchModrinthMod (builtins.attrValues {
              ClothConfig = {
                id = "wOP2dCdL";
                hash = "a6a41c16a4a284dc06e9dcbeca984c30c5e41ab6f6d82383b1e205e6b4d8ae2a";
              };
              FabricAPI = {
                id = "s9txaq7F";
                hash = "f5dfd5533945f16e363df9700c9e8158f9ed33f74b2760117d5e8830908bccda";
              };
              TextileBackup = {
                id = "uD4wiBTa";
                hash = "a2095a7294484a0b7f968cb12771afcbe6e5f0f56c5e974815084a15ff3c82f0";
              };
              Starlight = {
                id = "qH1xCwoC";
                hash = "2d07106e9ac267e3b889dad8a16eed34d746a148a1e070dbb2e0afa4ef97a573";
              };
              Lithium = {
                id = "pXdccFQf";
                hash = "859f5b05f48e6828c0697baa6555c8c370bfb351e4ee214494b13de4bf4e54e2";
              };
              FerriteCore = {
                id = "7epbwkFg";
                hash = "58ab281bc8efdb1a56dff38d6f143d2e53df335656d589adff8f07d082dbea77";
              };
            })));
      };
    };
  };
}
