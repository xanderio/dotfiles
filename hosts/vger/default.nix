{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../configuration/laptop
  ];

  hardware.opengl.extraPackages = with pkgs; [vaapiIntel libvdpau-va-gl vaapiVdpau intel-ocl];
  home-manager.users.xanderio.xanderio = {
    git = {
      enable = true;
      gpgFormat = "ssh";
      signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJDvsq3ecdR4xigCpOQVfmWZYY74KnNJIJ5Fo0FsZMGW";
    };
    prusa-slicer.enable = true;
    freecad.enable = true;
    mumble.enable = true;
    darktable.enable = true;
  };
}
