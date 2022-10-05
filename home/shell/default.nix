{ pkgs, ... }: {
  imports = [
    ./fish.nix
    ./git.nix
  ];

  home.packages = with pkgs; [
    nushell
    ripgrep
    fd
    htop
    file
    unzip
    httpie
    any-nix-shell
    comma
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
    gpg.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    exa = {
      enable = true;
      enableAliases = true;
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
    enable = true;
    pinentryFlavor = "curses";
  };
}