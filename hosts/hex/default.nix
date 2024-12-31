{
  inputs,
  pkgs,
  config,
  nixos-hardware,
  homeImports,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/laptop
    nixos-hardware.nixosModules.lenovo-thinkpad-t14
    { home-manager.users.xanderio.imports = homeImports."xanderio@hex"; }
  ];

  home-manager.users.xanderio.home.stateVersion = "22.11";
  deployment.targetHost = null;

  disko.devices = import ./disko.nix { disks = [ "/dev/nvme0n1" ]; };

  networking.hostName = "hex";
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  boot.supportedFilesystems = [ "zfs" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.extraModprobeConfig = ''
    # disable 802.11ax as it causes the driver to crash :(
    options iwlwifi disable_11ax=1
  '';
  networking.hostId = "8425e349";
  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    vaapiIntel
    libvdpau-va-gl
    vaapiVdpau
    intel-ocl
  ];
  environment.etc."openal/alsoft.conf".source = pkgs.writeText "alsoft.conf" "drivers=pulse";
  environment.variables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

  nix.settings = {
    substituters = [ "http://binary-cache-v2.vpn.cyberus-technology.de" ];
    trusted-public-keys = [
      "cyberus-1:0jjMD2b+guloGW27ZToxDQApCoWj+4ONW9v8VH/Bv0Q=" # v2 cache
    ];
  };

  home-manager.users.xanderio.home.packages = with pkgs; [ glab ];
  home-manager.users.xanderio.home.sessionVariables = {
    GLAB_PAGER = "cat";
  };

  home-manager.extraSpecialArgs = {
    inherit inputs;
  };
  home-manager.users.xanderio.xanderio = {
    git = {
      enable = true;
      email = "alexander.sieg@cyberus-technology.de";
      gpgFormat = "ssh";
      signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKSDJ6zHzaKb+bdDPm6iOplsLao/YJAepUr5Ja86gjN6";
    };
    sway.scale = "1.5";
  };

  system.stateVersion = "22.05";
}
