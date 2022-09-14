{ config
, pkgs
, lib
, name
, ...
}: {
  imports = [
    ../common
    ./backup.nix
    ./node_exporter.nix
    ./nginx.nix
    ./wireguard.nix
    ./promtail.nix
  ];

  zramSwap.enable = true;

  networking = {
    domain = "xanderio.de";
  };

  deployment.targetHost = "${config.networking.hostName}.${config.networking.domain}";
}
