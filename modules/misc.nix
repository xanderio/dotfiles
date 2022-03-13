{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    ripgrep
  ];

  programs.direnv.enable = true;
  programs.exa.enable = true;
  programs.jq.enable = true;
  programs.bat = {
    enable = true;
    config = {
      theme = "Dracula";
    };
  };
}
