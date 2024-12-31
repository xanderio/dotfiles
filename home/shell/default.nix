{ pkgs, lib, ... }:
{
  imports = [
    ./fish.nix
    ./git.nix
  ];

  home.packages = with pkgs; [
    nushell
    ripgrep
    fd
    sd
    htop
    file
    unzip
    nix-your-shell
    comma
    cachix
    nix-output-monitor
    gh
    httpie
  ];

  home.sessionVariables = {
    PAGER = "less";
    LESS = "-qR";
  };

  programs = {
    ssh = {
      enable = true;
      includes = [ "~/.ssh/private_ssh_config" ];
      matchBlocks.all.extraOptions.SetEnv = "TERM=xterm-256color";
    };
    gpg.enable = false;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    eza = {
      enable = true;
    };
    jq.enable = true;
    bat = {
      enable = true;
      config = {
        theme = "Catppuccin Mocha";
      };
      themes = {
        "Catppuccin_Mocha" = {
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "bat";
            rev = "699f60fc8ec434574ca7451b444b880430319941";
            hash = "sha256-6fWoCH90IGumAMc4buLRWL0N61op+AuMNN9CAR9/OdI=";
          };
          file = "themes/Catppuccin Mocha.tmTheme";
        };
      };
    };
    home-manager.enable = true;
    nix-index.enable = true;
    starship = {
      enable = true;
      settings = {
        palette = "catppuccin_mocha";
        command_timeout = 100;
        add_newline = false;
        directory = {
          truncation_length = 5;
          truncation_symbol = "…/";
        };
        status = {
          disabled = false;
          symbol = "🚨";
        };
        git_status.conflicted = "🤯";
      } // lib.importTOML ./starship_mocha.toml;
    };
  };

  services.gpg-agent = {
    enable = false;
    pinentryPackage = pkgs.pinentry-curses;
  };
}
