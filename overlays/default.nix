{
  pkgs,
  inputs,
}: [
  #inputs.neovim-nightly-overlay.overlay
  (final: prev: let
    nixpkgs = import inputs.nixpkgs-unstable {system = prev.system;};
  in {
    taplo-cli = nixpkgs.taplo-cli;
  })
  (import ../pkgs {})
]
