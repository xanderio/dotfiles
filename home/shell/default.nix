{ pkgs, ... }:
{
  imports = [
    ./fish.nix
    ./git.nix
  ];

  home.packages =
    with pkgs; [
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
        theme = "Dracula";
      };
    };
    home-manager.enable = true;
    nix-index.enable = true;
    starship = {
      enable = true;
      settings = {
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
      };
    };
  };

  services.gpg-agent = {
    enable = false;
    pinentryPackage = pkgs.pinentry-curses;
  };
}
