{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.xanderio.git;
  jujutsu-update = builtins.getFlake "github:xanderio/nixpkgs/b5707879922630226773033478ce726a12de2160";
in
{
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
    home.packages = with pkgs; [
      git-branchless
      watchman
      (jujutsu-update.legacyPackages.${pkgs.stdenv.system}.jujutsu.overrideAttrs (old: {
        patches = old.patches or [] ++ [
          (pkgs.fetchpatch2 {
            url = "https://patch-diff.githubusercontent.com/raw/jj-vcs/jj/pull/5612.patch";
            hash = "sha256-FAi9oKtGjBAKgOl4xVga9F7uywPPSATHFx+6URydC/8=";
          })
        ];
      }))
    ];
    programs.git = {
      enable = true;
      userName = "Alexander Sieg";
      userEmail = cfg.email;

      signing = {
        key = cfg.signingKey;
        format = "ssh";
        signByDefault = true;
      };

      aliases = rec {
        s = "status -s";
        ss = "status";
        a = "add";
        c = "commit";
        lg1 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
        lg2 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all";
        lg = lg1;
        pf = "push --force-with-lease";
        p = "push";
        P = "pull";
        pr = "pull -r";
        aa = "add .";
        ca = "commit --amend";
        cae = "commit --amend --no-edit";
      };

      ignores = [
        ".direnv"
        ".worktree"
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
        core = {
          editor = "nvim";
        };
        init = {
          defaultBranch = "main";
        };
        merge = {
          tool = "nvim";
          conflictstyle = "diff3";
        };
        mergetool = {
          keepBackup = false;
          prompt = false;
        };
        rebase.autosquash = true;
        "mergetool.nvim".cmd =
          "${pkgs.neovim}/bin/nvim -d -c \"wincmd l\" -c \"norm ]c\" \"$LOCAL\" \"$MERGED\" \"$REMOTE\"";
        push.autoSetupRemote = true;
      };

      lfs.enable = true;
    };
  };
}
