{ config, ... }: {
  imports = [
    ./headscale.nix
    ./gitea.nix
    ./configuration.nix
    ./loki.nix
  ];
  networking.hostName = "valen";
}
