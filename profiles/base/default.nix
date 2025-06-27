{ pkgs, ... }:
{
  imports = [
    ./zfs.nix
  ];

  nix.package = pkgs.lixPackageSets.latest.lix;
}
