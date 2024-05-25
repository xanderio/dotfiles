{
  imports = [
    ../common
    ./backup.nix
    ./node_exporter.nix
    ./nginx.nix
    ./wireguard.nix
  ];

  zramSwap.enable = true;

  networking = {
    domain = "xanderio.de";
  };

  deployment.tags = ["server"];

  documentation.nixos.enable = false;
}
