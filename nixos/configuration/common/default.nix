{ config, pkgs, lib, name, ... }:
{
  networking = {
    hostName = name;
    domain = "xanderio.de";
  };

  deployment.targetHost = "${config.networking.hostName}.${config.networking.domain}";

  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;
  services.openssh.challengeResponseAuthentication = false;
  services.openssh.permitRootLogin = "without-password";
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJDvsq3ecdR4xigCpOQVfmWZYY74KnNJIJ5Fo0FsZMGW"
  ];
}
