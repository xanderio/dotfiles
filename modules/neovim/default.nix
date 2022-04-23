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

    rnix-lsp
    rust-analyzer
    terraform-lsp
    taplo-cli
    shellcheck
    terraform

    statix
    alejandra
    gitlint

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
    }
    // lib.attrsets.mapAttrs'
      (name: drv:
        lib.attrsets.nameValuePair
          ("nvim/parser/"
          + (lib.strings.removePrefix "tree-sitter-" name)
          + ".so")
          { source = "${drv}/parser.so"; })
      pkgs.nvim-ts-grammars.builtGrammars;
}
