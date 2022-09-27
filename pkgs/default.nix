{ callPackage, ... }:
{
  nvim-ts-grammars = callPackage ./nvim-ts-grammars { };
  ferium = callPackage ./ferium { };
  ripdrag = callPackage ./ripdrag { };
  dioxus-cli = callPackage ./dioxus-cli { };
}
