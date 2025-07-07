{ lib, pkgs, ... }:
{
  imports = [
    ../../shell
    ../../develop
  ];
  xanderio.git.enable = true;
  home.username = "xanderio";
  home.homeDirectory = "/Users/xanderio";
  home.stateVersion = lib.mkForce "23.05";

  services.gpg-agent.enable = lib.mkForce false;

  home.packages = [ pkgs.incus.client ];
}
