{ callPackage, ... }: {
  nvim-ts-grammars = callPackage ./nvim-ts-grammars { };
  ferium = callPackage ./ferium { };
  dioxus-cli = callPackage ./dioxus-cli { };
  cargo-espflash = callPackage ./cargo-espflash { };
  cargo-espmonitor = callPackage ./cargo-espmonitor { };
}
