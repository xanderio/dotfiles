{config, ...}: {
  imports = [
    ../../configuration/server
    ./headscale.nix
    ./configuration.nix
  ];
}
