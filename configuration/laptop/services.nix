{pkgs, ...}: {
  # Enable CUPS to print documents.
  # services.printing.enable = true;

  services.blueman.enable = true;
  security.rtkit.enable = true;
  services.logind.lidSwitchExternalPower = "ignore";
  services.avahi = {
    enable = true;
    nssmdns = true;
    ipv4 = true;
    ipv6 = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };
  services.pcscd = {
    enable = true;
    plugins = [pkgs.ifdnfc];
  };

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    kbdInteractiveAuthentication = false;
    permitRootLogin = "without-password";
  };
  networking.firewall.allowedTCPPorts = [22];

  virtualisation.docker.enable = true;
  virtualisation.podman.enable = true;
}
