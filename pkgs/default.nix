{}: final: prev: {
  nvim-ts-grammars = prev.callPackage ./nvim-ts-grammars { };
  timewarrior-hook = prev.callPackage ./timewarrior-hook { };
  ferium = prev.callPackage ./ferium { };
}
