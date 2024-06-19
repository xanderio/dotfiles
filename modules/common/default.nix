{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./nix.nix
    ./users.nix
    ./upgrade-diff.nix
    ../authentik-proxy
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

  boot.tmp.cleanOnBoot = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "without-password";
    };
  };
  networking.firewall.allowedTCPPorts = [ 22 ];
  networking.firewall.trustedInterfaces = [ "tailscale0" ];
  systemd.network.wait-online.ignoredInterfaces = [ "tailscale0" ];

  environment.systemPackages = with pkgs; [
    htop
    neovim
  ];

  documentation.man.generateCaches = true;

  programs.fish.enable = true;

  security.sudo.wheelNeedsPassword = false;

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJDvsq3ecdR4xigCpOQVfmWZYY74KnNJIJ5Fo0FsZMGW"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKSDJ6zHzaKb+bdDPm6iOplsLao/YJAepUr5Ja86gjN6"
  ];

  services.tailscale.enable = true;

  security.acme = {
    defaults.email = "security@xanderio.de";
    acceptTerms = true;
  };

  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
}
