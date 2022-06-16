{ inputs
, pkgs
, config
, lib
, ...
}: {
  imports = [
    inputs.nix-minecraft.nixosModules.minecraft-servers
    ../../configuration/server
    ./hardware-configuration.nix
  ];

  boot.loader.grub.device = "/dev/sda";

  networking = {
    useDHCP = false;
    enableIPv6 = true;

    interfaces.enp1s0.useDHCP = true;
    interfaces.enp7s0.useDHCP = true;
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

  services.prometheus = {
    exporters = {
      node = {
        firewallFilter = lib.mkForce "-i enp7s0 -p tcp -m tcp --dport 9100";
      };
    };
  };

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
        max-players = 5;
        white-list = true;
      };
      whitelist = {
        "xanderio" = "40470409-787b-494a-ada2-49f097e7cf50";
        "MrKrisKrisu" = "09ad39cf-b231-4d2f-8efd-8deb1ebf52ab";
        "gim___" = "cac5d597-cd9a-43a4-9738-1f833b769ced";
        "telegnom" = "7767ea2a-4c84-4fec-a165-37161ecdf428";
      };
      symlinks = {
        mods = pkgs.linkFarmFromDrvs "mods" (map pkgs.fetchModrinthMod (builtins.attrValues {
          Starlight = {
            id = "zFqBnsxO";
            hash = "a3e54ff84c70ec4c57345e02ae059e2428da59ea087b8aaa6a4278f8a8c798f1";
          };
          Lithium = {
            id = "pXdccFQf";
            hash = "859f5b05f48e6828c0697baa6555c8c370bfb351e4ee214494b13de4bf4e54e2";
          };
          FerriteCore = {
            id = "7epbwkFg";
            hash = "58ab281bc8efdb1a56dff38d6f143d2e53df335656d589adff8f07d082dbea77";
          };
          Krypton = {
            id = "UJ6FlFnK";
            hash = "2383b86960752fef9f97d67f3619f7f022d824f13676bb8888db7fea4ad1f76a";
          };
          LazyDFU = {
            id = "4SHylIO9";
            hash = "8c7993348a12d607950266e7aad1040ac99dd8fe35bb43a96cc7ff3404e77c5d";
          };
        }));
      };
    };
  };
}
