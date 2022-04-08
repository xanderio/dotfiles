{ config, pkgs, libs, ... }:
{
  programs.home-manager.enable = true;
  home.sessionVariables = {
    DARCS_ALWAYS_COLOR = "1";
    DARCS_ALTERNATIVE_COLOR = "1";
    DARCS_DO_COLOR_LINES = "1";

    MANPAGER = "nvim +Man!";
    BROWSER = "firefox";
    PAGER = "less";
    LESS = "-qR";

    WLR_DRM_NO_MODIFIERS = "1";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    XCURSOR_THEME = "Bibata-Modern-Classic";
  };
}
