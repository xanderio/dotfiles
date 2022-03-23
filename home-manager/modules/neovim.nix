{ config, pkgs, lib, ... }:

{
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    neovim-nightly
    lua51Packages.mpack

    rnix-lsp
    rust-analyzer
    terraform-lsp
    taplo-lsp
    shellcheck

    nodePackages.bash-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.pyright
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.yaml-language-server
    nodePackages.vscode-css-languageserver-bin

    # Formatter
    nodePackages.prettier
    nixpkgs-fmt
    rustfmt
    terraform
  ];

  home.shellAliases = {
    vi = "nvim";
    vim = "nvim";
  };

  xdg.configFile = {
    "nvim" = {
      recursive = true;
      source = ../configs/nvim;
    };
  } // lib.attrsets.mapAttrs' (name: drv:
      lib.attrsets.nameValuePair ("nvim/parser/"
        + (lib.strings.removePrefix "tree-sitter-" name)
        + ".so") { source = "${drv}/parser.so"; }) pkgs.nvim-ts-grammars.builtGrammars; 
}
