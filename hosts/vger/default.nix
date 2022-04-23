{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../configuration/laptop
  ];

  home-manager.users.xanderio.xanderio = {
    minecraft.enable = true;
    git = {
      enable = true;
      gpgFormat = "ssh";
      signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJDvsq3ecdR4xigCpOQVfmWZYY74KnNJIJ5Fo0FsZMGW";
    };
    cura.enable = true;
    freecad.enable = true;
    mumble.enable = true;
  };
}
