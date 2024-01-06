{
  imports = [
    ../../modules/server
    ../../profiles/hetzner_vm

    ./miniflux.nix
    ./ntfy.nix
    ./website.nix
    ./authentik.nix
    ./postgresql.nix
    ./matrix.nix

    ./disko-config.nix
  ];
  networking.hostName = "carrot";

  deployment.targetHost = "carrot.xanderio.de";
  systemd.network.networks."10-uplink".networkConfig.Address = "2a01:4f9:c010:ef51::1/64";

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.journald.extraConfig = ''
    SystemMaxUse = 1G
  '';
}
