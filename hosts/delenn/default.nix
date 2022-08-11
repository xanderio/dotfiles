{ name
, nodes
, pkgs
, ...
}: {
  imports = [
    ../../configuration/server
    ./configuration.nix
  ];
}
