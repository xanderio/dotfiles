{ pkgs, ... }:
{
  home.packages = with pkgs; [
    any-nix-shell
    comma
    colmena
  ];
  programs.nix-index.enable = true;
}
