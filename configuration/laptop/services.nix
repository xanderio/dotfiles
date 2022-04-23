{pkgs, ...}: {
  # Enable CUPS to print documents.
  # services.printing.enable = true;

  services.blueman.enable = true;
  security.rtkit.enable = true;
  services.logind.lidSwitchExternalPower = "ignore";
  services.pcscd = {
    enable = true;
    plugins = [pkgs.ifdnfc];
  };

  virtualisation.docker.enable = true;
  virtualisation.podman.enable = true;
  virtualisation.libvirtd.enable = true;
}
