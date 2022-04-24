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
    cura.enable = mkEnableOption "cura";
    freecad.enable = mkEnableOption "freecad";
    android-studio.enable = mkEnableOption "android-studio";
    mumble.enable = mkEnableOption "mumble";
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

        thunderbird
      ]
      ++ optional cfg.cura.enable pkgs.cura
      ++ optional cfg.freecad.enable pkgs.freecad
      ++ optional cfg.android-studio.enable pkgs.android-studio
      ++ optional cfg.mumble.enable pkgs.mumble;

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
