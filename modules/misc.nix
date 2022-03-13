{ config, pkgs, ... }:
{
  programs.direnv.enable = true;
  programs.exa.enable = true;
  programs.bat = {
    enable = true;
    config = {
      theme = "Dracula";
    };
  };
}
