{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.xanderio;
in {
  options.xanderio = {
    prusa-slicer.enable = mkEnableOption "prusa-slicer";
    freecad.enable = mkEnableOption "freecad";
    android-studio.enable = mkEnableOption "android-studio";
    mumble.enable = mkEnableOption "mumble";
    darktable.enable = mkEnableOption "darktable";
  };
  config = {
    home.packages = with pkgs;
      [
        ripgrep
        fd
        htop
        file
        unzip
        ldns # drill
        httpie
        pre-commit

        thunderbird
        imv
      ]
      ++ optional cfg.prusa-slicer.enable pkgs.prusa-slicer
      ++ optional cfg.freecad.enable pkgs.freecad
      ++ optional cfg.android-studio.enable pkgs.android-studio
      ++ optional cfg.mumble.enable pkgs.mumble
      ++ optional cfg.darktable.enable pkgs.darktable;

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    programs.exa.enable = true;
    programs.jq.enable = true;
    programs.bat = {
      enable = true;
      config = {
        theme = "Dracula";
      };
    };
  };
}
