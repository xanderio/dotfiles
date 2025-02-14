{ lib, ... }:
{
  imports = [
    ../../shell
    ../../develop
  ];
  xanderio.git.enable = true;

  services.gpg-agent.enable = lib.mkForce false;
}
