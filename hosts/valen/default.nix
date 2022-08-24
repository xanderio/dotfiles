{ config, ... }: {
  imports = [
    ./headscale.nix
    ./gitea.nix
    ./configuration.nix
  ];
  networking.hostName = "valen";
}
