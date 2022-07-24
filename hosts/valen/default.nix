{ config, ... }: {
  imports = [
    ../../configuration/server
    ./headscale.nix
    ./gitea.nix
    ./configuration.nix
  ];
}
