{
  pkgs,
  inputs,
}: [
  inputs.neovim-nightly-overlay.overlay
  (final: prev: let
    nixpkgs = import inputs.taplo-update {system = prev.system;};
  in {
    taplo-cli = nixpkgs.taplo-cli;
  })
  (final: prev: {
    nvim-ts-grammars = prev.callPackage ../pkgs/nvim-ts-grammars {};
    timewarrior-hook = prev.callPackage ../pkgs/timewarrior-hook {};
  })
]
