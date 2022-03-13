{ config, pkgs, libs, ... }:

{
  home.packages = with pkgs; [
    neovim

    rnix-lsp
    nixpkgs-fmt
    rust-analyzer
  ];

  home.shellAliases = {
    vi = "nvim";
    vim = "nvim";
  };

  xdg.configFile."nvim" = {
    recursive = true;
    source = ../configs/nvim;
  };
}
