{ self, inputs, ... }:
let
  inherit (inputs.nixpkgs) lib;

  filterSystem = system: lib.filterAttrs (_: darwin: darwin.pkgs.stdenv.hostPlatform.system == system);
in
{
  perSystem =
    { system, ... }:
    {
      checks = lib.mapAttrs' (
        name: darwin: lib.nameValuePair "darwinConfigurations-${name}" darwin.config.system.build.toplevel
      ) (filterSystem system self.darwinConfigurations);
    };
}
