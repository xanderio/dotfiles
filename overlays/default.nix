{ pkgs
, inputs
,
}: [
  inputs.neovim-nightly-overlay.overlay
  inputs.nix-minecraft.overlay
  inputs.fenix.overlay
  inputs.polymc.overlay
  (final: prev:
    let
      nixpkgs = import inputs.iwgtk-06 { system = prev.system; };
    in
    {
      iwgtk = nixpkgs.iwgtk;
    })
  (
    final: prev:
      let
        callPackage = prev.callPackage;
      in
      (import ../pkgs { inherit callPackage; })
  )
]
