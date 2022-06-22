{ pkgs
, inputs
,
}: [
  inputs.neovim-nightly-overlay.overlay
  inputs.nix-minecraft.overlay
  (final: prev: {
    bibata-cursors = prev.bibata-cursors.override { clickgen = prev.python39Packages.clickgen; };
  })
  (final: prev:
    let
      nixpkgs = import inputs.iwgtk-06 { system = prev.system; };
    in
    {
      iwgtk = nixpkgs.iwgtk;
    })
  (import ../pkgs { })
]
