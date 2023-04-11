{ pkgs
, lib
, config
, ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  disko.devices = import ./disko.nix {
    disks = ["/dev/nvme0n1"];
  };

  networking.hostName = "hex";
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  boot.supportedFilesystems = [ "zfs" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.extraModprobeConfig = ''
    # disable 802.11ax as it causes the driver to crash :(
    options iwlwifi disable_11ax=1
  '';
  networking.hostId = "8425e349";
  hardware.opengl.extraPackages = with pkgs; [
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
    substituters = [
      "http://binary-cache-v2.vpn.cyberus-technology.de"
    ];
    trusted-public-keys = [
      "cyberus-1:0jjMD2b+guloGW27ZToxDQApCoWj+4ONW9v8VH/Bv0Q=" # v2 cache
    ];
  };

  home-manager.users.xanderio.home.packages = with pkgs; [ glab ];
  home-manager.users.xanderio.xanderio = {
    git = {
      enable = true;
      email = "alexander.sieg@cyberus-technology.de";
      gpgFormat = "ssh";
      signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKSDJ6zHzaKb+bdDPm6iOplsLao/YJAepUr5Ja86gjN6";
    };
    sway.scale = "1.5";
  };
}
