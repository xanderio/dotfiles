{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../configuration/laptop
  ];

  hardware.opengl.extraPackages = with pkgs; [
    intel-media-driver
    vaapiIntel
    libvdpau-va-gl
    vaapiVdpau
    intel-ocl
  ];
  environment.variables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
  networking.hostId = "ce58a733";
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
    prusa-slicer.enable = true;
    freecad.enable = true;
    mumble.enable = true;
    minecraft.enable = true;
    darktable.enable = true;
    digikam.enable = true;
  };
}
