{ config
, pkgs
, lib
, ...
}: {
  home.sessionVariables = {
    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
  };

  home.packages = with pkgs; [
    neovim-nightly
    lua51Packages.mpack

    nil
    rust-analyzer-nightly
    terraform-lsp
    taplo-cli
    shellcheck
    terraform

    statix
    nixpkgs-fmt
    gitlint
    hadolint

    nodePackages.bash-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.yaml-language-server
    nodePackages.vscode-css-languageserver-bin
    nodePackages.prettier

    nodePackages.pyright
    black
    python3Packages.isort
    python3Packages.flake8
    python3Packages.pylama
  ];

  home.shellAliases = {
    vi = "nvim";
    vim = "nvim";
  };

  xdg.configFile =
    {
      "nvim" = {
        recursive = true;
        source = ./nvim;
      };
      "nvim/parser/" = {
        recursive = true;
        source = pkgs.nvim-ts-grammars;
      };
    };
}