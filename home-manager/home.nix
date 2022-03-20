{ config, pkgs, ... }:
{
  imports = [
    ./modules/git.nix
    ./modules/fish.nix
    ./modules/foot.nix
    ./modules/misc.nix
    ./modules/sway.nix
    ./modules/neovim.nix
    ./modules/nix-utilities.nix
    ./modules/games.nix

    ./modules/work.nix
  ];
  # Whether to enable settings that make Home Manager work better on GNU/Linux
  # distributions other than NixOS. 
  #targets.genericLinux.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "xanderio";
  home.homeDirectory = "/home/xanderio";

  home.sessionVariables = {
    DARCS_ALWAYS_COLOR = "1";
    DARCS_ALTERNATIVE_COLOR = "1";
    DARCS_DO_COLOR_LINES = "1";

    MANPAGER = "nvim +Man!";
    BROWSER = "firefox";
    PAGER = "less";
    LESS = "-qR";

    WLR_DRM_NO_MODIFIERS = "1";
    MOZ_ENABLE_WAYLAND = "1";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    XCURSOR_THEME = "Bibata-Modern-Classic";
  };

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
  };

  fonts.fontconfig.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;
}
