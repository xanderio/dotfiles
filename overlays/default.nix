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
  (final: prev: let
    nixpkgs = import inputs.colmena {system = prev.system;};
  in {
    colmena = nixpkgs.colmena;
  })
  (import ../pkgs {})
]
