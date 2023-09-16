{
  imports = [
    ./configuration.nix
    ./loki.nix
    ../../modules/server
  ];
  deployment.targetHost = "valen.xanderio.de";
  networking.hostName = "valen";
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };
  services.journald.extraConfig = ''
    SystemMaxUse = 1G
  '';
}
