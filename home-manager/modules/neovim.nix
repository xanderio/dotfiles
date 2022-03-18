{ config, pkgs, libs, ... }:

{
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    neovim
    clang
    lua51Packages.mpack

    rnix-lsp
    nixpkgs-fmt
    rust-analyzer
    taplo-lsp
    shellcheck
  ];

  home.shellAliases = {
    vi = "nvim";
    vim = "nvim";
  };

  xdg.configFile."nvim" = {
    recursive = true;
    source = ../configs/nvim;
  };
  
  xdg.configFile."nvim/parser" = {
    recursive = true;
    source = pkgs.tree-sitter.withPlugins(_: pkgs.tree-sitter.allGrammars);
  };
}
