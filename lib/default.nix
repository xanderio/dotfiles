{
  nixpkgs,
  home-manager,
  pkgs,
  overlays,
  system,
  inputs,
  ...
}: {
  mkHost = {
    name,
    modules,
  }:
    nixpkgs.lib.nixosSystem {
      inherit system pkgs;
      specialArgs = inputs;
      modules =
        [
          {
            networking.hostName = name;
          }
          (../hosts + "/${name}")
        ]
        ++ modules;
    };
}
