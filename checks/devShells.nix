{ inputs, ... }:
let
  inherit (inputs.nixpkgs) lib;
in
{
  perSystem =
    { self', ... }:
    {
      checks = lib.mapAttrs' (name: value: lib.nameValuePair "devShell-${name}" value) self'.devShells;
    };
}
