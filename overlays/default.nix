{
  pkgs,
  inputs,
}: [
  inputs.neovim-nightly-overlay.overlay
  inputs.nix-minecraft.overlay
  inputs.fenix.overlay
  (final: prev: let
    nixpkgs = import inputs.iwgtk-06 {system = prev.system;};
  in {
    iwgtk = nixpkgs.iwgtk;
  })
  (import ../pkgs {})
]
