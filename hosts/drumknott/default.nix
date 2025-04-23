{
  pkgs,
  lib,
  homeImports,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/server
    { home-manager.users.xanderio.imports = homeImports."vetinari"; }
    ./audiobookshelf.nix
    ./plex.nix
  ];


  networking.nftables.enable = true;

  networking = {
    interfaces."enp3s0" = {
      ipv4.addresses = [
        {
          address = "45.140.180.76";
          prefixLength = 29;
        }
      ];
      ipv6.addresses = [
        {
          address = "2a0e:c5c0:0:304::4";
          prefixLength = 64;
        }
      ];
    };
    defaultGateway = {
      address = "45.140.180.73";
      interface = "enp3s0";
    };
    defaultGateway6 = {
      address = "2a0e:c5c0:0:304::1";
      interface = "enp3s0";
    };
  };

  deployment.targetHost = "drumknott.xanderio.de";
  home-manager.users.xanderio.home.stateVersion = "25.05";

  networking.hostName = "drumknott";
  networking.hostId = "8224ef4d";

  networking.useNetworkd = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 2;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.supportedFilesystems = [ "zfs" ];

  boot.zfs.extraPools = [ "tank" ];

  system.stateVersion = "25.05";
}
