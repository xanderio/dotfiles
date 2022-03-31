{ config, pkgs, ... }:
{
  imports = [
    ./modules/git.nix
    ./modules/fish.nix
    ./modules/starship.nix
    ./modules/foot.nix
    ./modules/misc.nix
    ./modules/sway.nix
    ./modules/neovim.nix
    ./modules/nix-utilities.nix
    ./modules/games.nix
    ./modules/gtk.nix
    ./modules/ssh.nix
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

  programs.chromium = {
    enable = true;
  };
  nixpkgs.config.chromium.commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";

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
  nixpkgs.overlays = [
    (self: super:
      let
        nixpkgs-master = import
          (super.fetchFromGitHub {
            owner = "NixOS";
            repo = "nixpkgs";
            rev = "e01c41205234a68a55903e05800e62d0de302e1a";
            sha256 = "070n3vjz7srfwf2x7k1x3gnjfldwsj9zw4w9vr1x3my2wyq16qa3";
          })
          { };
      in
      {
        fuzzel = nixpkgs-master.fuzzel;
      })
    (import ./pkgs)
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];
}
