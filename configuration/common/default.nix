{
  config,
  pkgs,
  lib,
  name,
  ...
}: {
  imports = [
    ./node_exporter.nix
    ./nginx.nix
    ./nix.nix
    ./wireguard.nix
  ];

  networking = {
    hostName = name;
    domain = "xanderio.de";
  };

  deployment.targetHost = "${config.networking.hostName}.${config.networking.domain}";

  boot.cleanTmpDir = true;
  zramSwap.enable = true;

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    kbdInteractiveAuthentication = false;
    permitRootLogin = "without-password";
  };
  networking.firewall.allowedTCPPorts = [22];

  environment.systemPackages = with pkgs; [
    htop
    neovim
  ];

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJDvsq3ecdR4xigCpOQVfmWZYY74KnNJIJ5Fo0FsZMGW"
  ];

  security.acme = {
    defaults.email = "security@xanderio.de";
    acceptTerms = true;
  };
}
