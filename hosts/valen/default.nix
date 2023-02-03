{ config, ... }: {
  imports = [
    ./headscale.nix
    ./configuration.nix
    ./loki.nix
    ./outline.nix
  ];
  networking.hostName = "valen";
}
