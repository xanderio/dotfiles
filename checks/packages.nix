{ inputs, ... }:
let
  inherit (inputs.nixpkgs) lib;
in
{
  perSystem =
    { self', ... }:
    {
      checks = lib.mapAttrs' (name: value: lib.nameValuePair "package-${name}" value) self'.packages;
    };
}
