{ config, pkgs, lib, name, ... }:
{
  networking = {
    hostName = name;
    domain = "xanderio.de";
  };

  deployment.targetHost = "${config.networking.hostName}.${config.networking.domain}";

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    challengeResponseAuthentication = false;
    permitRootLogin = "without-password";
  };

  environment.systemPackages = with pkgs; [
    neovim
  ];

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJDvsq3ecdR4xigCpOQVfmWZYY74KnNJIJ5Fo0FsZMGW"
  ];

  security.acme.email = "security@xanderio.de";
  security.acme.acceptTerms = true;
}
