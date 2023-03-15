{ config, lib, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "vetinari";

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = lib.mkForce "23.05";
}
