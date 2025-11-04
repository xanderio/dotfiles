{
  pkgs,
  lib,
  homeImports,
  config,
  ...
}:
{
  imports = [
    ./backup.nix
    ./hardware-configuration.nix
    ./audio.nix
    ./paperless.nix
    # ./ddclient.nix
    ./hass.nix
    ./nextcloud.nix
    ./smb.nix
    ./incus.nix
    ./libvirt.nix
    ./immich.nix
    ../../modules/server
    { home-manager.users.xanderio.imports = homeImports."vetinari"; }
  ];

  networking.nftables.enable = true;

  # remove once reinstalled. workaround for disko changes.
  fileSystems = {
    "/boot".device = lib.mkForce "/dev/disk/by-partlabel/ESP";
  };
  swapDevices = lib.mkForce [
    {
      device = "/dev/disk/by-partlabel/swap";
      randomEncryption.enable = true;
    }
  ];

  deployment.targetHost = "vetinari.xanderio.de";
  home-manager.users.xanderio.home.stateVersion = "22.11";

  networking.hostName = "vetinari";
  networking.hostId = "8419e344";

  disko.devices = import ./disko.nix { disks = [ "/dev/sda" ]; };

  services.postgresql = {
    package = pkgs.postgresql_18;
  };

  networking.useNetworkd = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 2;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.supportedFilesystems = [ "zfs" ];

  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    libvdpau-va-gl
    intel-vaapi-driver
    libva-vdpau-driver
    intel-ocl
  ];

  system.stateVersion = "23.05";
}
