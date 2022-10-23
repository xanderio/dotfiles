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

  system.autoUpgrade = {
    enable = true;
    flake = "github:xanderio/dotfiles";
    dates = "04:00";
  };
}
