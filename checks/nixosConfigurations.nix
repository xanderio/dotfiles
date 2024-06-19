{ self, inputs, ... }:
let
  inherit (inputs.nixpkgs) lib;

  filterSystem = system: lib.filterAttrs (_: nixos: nixos.pkgs.hostPlatform.system == system);
in
{
  perSystem =
    { system, ... }:
    {
      checks = lib.mapAttrs' (
        name: nixos: lib.nameValuePair "nixosConfigurations-${name}" nixos.config.system.build.toplevel
      ) (filterSystem system self.nixosConfigurations);
    };
}
