{ pkgs, ... }:
{
  xdg.configFile."swaylock/config".source = ./config;
}
