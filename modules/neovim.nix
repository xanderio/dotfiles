{ config, pkgs, libs, ... }:

{
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    neovim

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
}
