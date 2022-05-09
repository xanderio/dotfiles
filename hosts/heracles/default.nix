{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../configuration/laptop
  ];

  hardware.opengl.extraPackages = with pkgs; [mesa.drivers];
  home-manager.users.xanderio = {
    home.packages = with pkgs; [glab];
    xanderio = {
      sway.scale = "1.4";
      git = {
        enable = true;
        email = "alexander.sieg@binary-butterfly.de";
        signingKey = "0x3ABD985B2004F8E6";
        gpgFormat = "openpgp";
      };
    };
  };
}
