{ config, pkgs, ... }:

{
  imports = [
    ./modules/neovim.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "xanderio";
  home.homeDirectory = "/home/xanderio";

  home.sessionVariables = {
    EDITOR = "nvim";
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

  programs.fish = {
    enable = true;
    shellAliases = {
      hm = "home-manager";
    };
    shellInit = ''
      set fish_color_normal normal
      set fish_color_command cyan
      set fish_color_param white
      set fish_color_redirection green
      set fish_color_comment black
      set fish_color_error red
      set fish_color_escape red
      set fish_color_operator red
      set fish_color_end green
      set fish_color_quote yellow
      set fish_color_autosuggestion brblack
      set fish_color_valid_path --underline
      set fish_color_cwd white
      set fish_color_cwd_root white
      set fish_color_match white
      set fish_color_search_match --background=black
      set fish_color_selection --background=green
      set fish_pager_color_prefix white
      set fish_pager_color_completion white
      set fish_pager_color_description white
      set fish_pager_color_progress white
      set fish_color_history_current white

      set fish_cursor_unknown block
      set -ax NIX_PATH $HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels
      # nix
      set fish_function_path ${pkgs.fishPlugins.foreign-env}/share/fish/vendor_functions.d $fish_function_path
      if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
          fenv source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
      end
    '';
  };
  xdg.configFile."fish/functions/fish_title.fish".source = ./configs/fish/functions/fish_title.fish;
  xdg.configFile."fish/functions/fish_greeting.fish".source = ./configs/fish/functions/fish_title.fish;

  programs.starship = {
    enable = true;
    settings = {
      command_timeout = 100;
      add_newline = false;
    };
  };

  programs.git = {
    enable = true;
    userName = "Alexander Sieg";
    userEmail = "alex@xanderio.de";

    aliases = {
      s = "status";
    };

    includes = [
      {
        path = "~/Work/.gitconfig";
        condition = "gitdir:~/Work";
      }
    ];

    ignores = [
      ".direnv"
      ".envrc"
      ".env"
    ];

    delta = {
      enable = true;
      options = {
        syntax-theme = "Dracula";
        features = "side-by-side line-numbers decorations";
        whitespace-error-style = "22 reverse";
        decorations = {
          commit-decoration-style = "bold yellow box ul";
          file-style = "bold yellow ul";
          file-decoration-style = "none";
        };
      };
    };
    extraConfig = {
      user = {
        signingkey = "alex@xanderio.de";
      };
      core = {
        editor = "nvim";
      };
      init = {
        defaultBranch = "main";
      };
      merge = {
        conflictstyle = "diff3";
      };
    };

    lfs.enable = true;
  };

  programs.direnv.enable = true;
  programs.exa.enable = true;
  programs.bat.enable = true;

  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "JetBrains Mono:size=10:weight=bold,Iosevka Term:size=12,TwitterColorEmoji";
        dpi-aware = "off";
      };
      bell.urgent = "yes";
      scrollback.lines = "100000";
      cursor.color = "82a36 f8f8f2";
      tweak.grapheme-shaping = "yes";
      colors = {
        alpha = "0.80";
        foreground = "f8f8f2";
        background = "282a36";
        regular0 = "000000";
        regular1 = "ff5555";
        regular2 = "50fa7b";
        regular3 = "f1fa8c";
        regular4 = "bd93f9";
        regular5 = "ff79c6";
        regular6 = "8be9fd";
        regular7 = "bfbfbf";
        bright0 = "4d4d4d";
        bright1 = "ff6e67";
        bright2 = "5af78e";
        bright3 = "f4f99d";
        bright4 = "caa9fa";
        bright5 = "ff92d0";
        bright6 = "9aedfe";
        bright7 = "e6e6e6";
      };
    };
  };

  home.packages = with pkgs; [
    delta
    rnix-lsp
    nixpkgs-fmt
  ];

  /* xdg.configFile."foot/foot.ini".source = ./configs/foot/foot.ini; */

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
}
