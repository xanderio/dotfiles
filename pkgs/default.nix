{ callPackage, ... }:
{
  nvim-ts-grammars = callPackage ./nvim-ts-grammars { };
  dioxus-cli = callPackage ./dioxus-cli { };
}
