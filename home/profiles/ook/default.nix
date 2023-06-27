{ lib, ...}: {
  imports = [
    ../../shell
    ../../develop
  ];
  home.username = "xanderio";
  home.homeDirectory = "/Users/xanderio";
  home.stateVersion = lib.mkForce "23.05";

  services.gpg-agent.enable = lib.mkForce false;
}
