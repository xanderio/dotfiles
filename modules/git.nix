{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.xanderio.git;
in {
  options.xanderio.git = {
    enable = mkEnableOption "git";
    email = mkOption {
      type = types.str;
      default = "alex@xanderio.de";
    };
    signingKey = mkOption {
      type = types.str;
      default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJDvsq3ecdR4xigCpOQVfmWZYY74KnNJIJ5Fo0FsZMGW";
    };
    gpgFormat = mkOption {
      type = types.str;
      default = "ssh";
    };
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = "Alexander Sieg";
      userEmail = cfg.email;

      signing = {
        key = cfg.signingKey;
        signByDefault = true;
      };

      aliases = {
        s = "status";
      };

      includes = [
        {
          path = "~/Work/.gitconfig";
          condition = "gitdir:~/Work/";
        }
      ];

      ignores = [
        ".direnv"
        ".envrc"
        ".env"
        "env"
      ];

      difftastic = {
        enable = true;
        background = "dark";
      };

      delta = {
        enable = false;
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
        gpg.format = cfg.gpgFormat;
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
  };
}
