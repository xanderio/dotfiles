{ config
, pkgs
, lib
, ...
}:
with lib; let
  cfg = config.xanderio;
in
{
  options.xanderio = {
    android-studio.enable = mkEnableOption "android-studio";
    mumble.enable = mkEnableOption "mumble";
    darktable.enable = mkEnableOption "darktable";
    digikam.enable = mkEnableOption "digikam";
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

        thunderbird-bin
        imv
        mpv
        pdfarranger
        freecad
      ]
      ++ optional cfg.android-studio.enable pkgs.android-studio
      ++ optional cfg.mumble.enable pkgs.mumble
      ++ optional cfg.digikam.enable pkgs.digikam
      ++ optional cfg.darktable.enable pkgs.darktable;

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    programs.exa = {
      enable = true;
      enableAliases = true;
    };
    programs.jq.enable = true;
    programs.bat = {
      enable = true;
      config = {
        theme = "Dracula";
      };
    };
  };
}
