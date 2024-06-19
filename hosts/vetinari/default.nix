{
  pkgs,
  config,
  lib,
  homeImports,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./spotifyd.nix
    ./audio.nix
    ./paperless.nix
    ./audiobookshelf.nix
    ./ddclient.nix
    ./hass.nix
    ./nextcloud.nix
    ./netatalk.nix
    ./jellyfin.nix
    ./shairport.nix
    ./incus.nix
    ../../modules/server
    { home-manager.users.xanderio.imports = homeImports."server"; }
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

  networking.useNetworkd = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 2;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  boot.supportedFilesystems = [ "zfs" ];

  boot.zfs.extraPools = [ "media" ];

  services.syncthing = {
    enable = true;
    relay.enable = true;
    openDefaultPorts = true;
    settings = {
      options = {
        urAccepted = -1;
        localAnnounceEnabled = true;
      };
    };
    overrideDevices = false;
    overrideFolders = false;
  };

  hardware.opengl.enable = true;
  hardware.opengl.extraPackages = with pkgs; [
    intel-media-driver
    vaapiIntel
    libvdpau-va-gl
    vaapiVdpau
    intel-ocl
  ];

  system.stateVersion = lib.mkForce "23.05";
}
