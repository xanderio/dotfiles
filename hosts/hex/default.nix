{ pkgs
, lib
, ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "hex";
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware.video.hidpi.enable = true;
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

  services.openvpn.servers.office = {
    config = ''
      config /var/lib/cyberus-openvpn/openvpn.conf
    '';
    updateResolvConf = false;
    up = "${pkgs.update-systemd-resolved}/libexec/openvpn/update-systemd-resolved";
    down = "${pkgs.update-systemd-resolved}/libexec/openvpn/update-systemd-resolved";
  };

  home-manager.users.xanderio.xanderio = {
    git = {
      enable = true;
      gpgFormat = "ssh";
      signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKSDJ6zHzaKb+bdDPm6iOplsLao/YJAepUr5Ja86gjN6";
    };
    sway.scale = "1.5";
  };
}
