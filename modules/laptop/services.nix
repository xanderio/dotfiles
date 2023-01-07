{ pkgs, ... }: {
  # Enable CUPS to print documents.
  # services.printing.enable = true;

  services.blueman.enable = true;
  security.rtkit.enable = true;
  services.logind.lidSwitchDocked = "ignore";
  services.avahi = {
    enable = false;
    nssmdns = true;
    ipv4 = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };
  services.pcscd = {
    enable = true;
    plugins = [ pkgs.ifdnfc ];
  };

  services.fwupd.enable = true;
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    kbdInteractiveAuthentication = false;
    permitRootLogin = "without-password";
  };
  networking.firewall.allowedTCPPorts = [ 22 ];

  virtualisation = {
    docker.enable = false;
    podman = {
      enable = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enable = true;
    };
  };
}
