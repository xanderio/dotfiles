{ pkgs
, lib
, ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "vger";
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  hardware.opengl.extraPackages = with pkgs; [
    intel-media-driver
    vaapiIntel
    libvdpau-va-gl
    vaapiVdpau
    intel-ocl
  ];
  environment.etc."openal/alsoft.conf".source = pkgs.writeText "alsoft.conf" "drivers=pulse";
  environment.systemPackages = [ pkgs.vial ];
  environment.variables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };
  home-manager.users.xanderio.xanderio = {
    git = {
      enable = true;
      gpgFormat = "ssh";
      signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJDvsq3ecdR4xigCpOQVfmWZYY74KnNJIJ5Fo0FsZMGW";
    };
    mumble.enable = true;
    minecraft.enable = true;
    darktable.enable = true;
    digikam.enable = true;
    sway.scale = "1.1";
  };
}
