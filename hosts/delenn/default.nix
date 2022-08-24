{ pkgs
, ...
}: {
  imports = [
    ./configuration.nix
  ];
  networking.hostName = "delenn";
}
