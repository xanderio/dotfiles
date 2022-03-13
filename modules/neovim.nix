{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    neovim
  ];

  home.shellAliases = {
    vi = "nvim";
    vim = "nvim";
  };
}
