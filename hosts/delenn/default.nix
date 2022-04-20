{
  name,
  nodes,
  pkgs,
  ...
}: {
  imports = [
    ../../configuration/common
    ./configuration.nix
  ];
}
