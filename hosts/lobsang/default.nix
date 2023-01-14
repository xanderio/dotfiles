{ pkgs
, config
, lib
, ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "zfs" ];
  networking.hostId = "42b09e26";
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;

  networking.hostName = "lobsang";

  services.openssh.enable = true;
  
}
