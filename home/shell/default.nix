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
        "Catppuccin Mocha" = {
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
        git_state.disabled = true;
        git_commit.disabled = true;
        git_metrics.disabled = true;
        git_branch.disabled = true;
        git_status.conflicted = "🤯";
        custom = {
          jj = {
            when = true;
            ignore_timeout = true;
            description = "current jj status";
            symbol = "";
            command = ''
              jj root > /dev/null && jj log --revisions @ --no-graph --ignore-working-copy --color always --limit 1 --template '
                separate(" ",
                  "🥋",
                  change_id.shortest(4),
                  bookmarks,
                  "|",
                  concat(
                    if(conflict, "💥"),
                    if(divergent, "🚧"),
                    if(hidden, "👻"),
                    if(immutable, "🔒"),
                  ),
                  raw_escape_sequence("\x1b[1;32m") ++ if(empty, "(empty)"),
                  raw_escape_sequence("\x1b[1;32m") ++ if(description.first_line().len() == 0,
                    "(no description set)",
                    if(description.first_line().substr(0, 29) == description.first_line(),
                      description.first_line(),
                      description.first_line().substr(0, 29) ++ "…",
                    )
                  ) ++ raw_escape_sequence("\x1b[0m"),
                )
              '
            '';
          };
          git_branch = {
            when = true;
            ignore_timeout = true;
            command = "jj root >/dev/null 2>&1 || starship module git_branch";
            description = "Only show git_branch if we're not in a jj repo";
          };
        };
      } // lib.importTOML ./starship_mocha.toml;
    };
  };

  services.gpg-agent = {
    enable = false;
    pinentryPackage = pkgs.pinentry-curses;
  };
}
