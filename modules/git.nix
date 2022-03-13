{ config, pkgs, ... }:

{
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
}
