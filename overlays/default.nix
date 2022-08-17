{ pkgs
, inputs
,
}: [
  inputs.neovim-nightly-overlay.overlay
  inputs.nix-minecraft.overlay
  inputs.fenix.overlay
  (final: prev:
    let
      nixpkgs = import inputs.iwgtk-06 { system = prev.system; };
    in
    {
      inherit (inputs.nil.packages."x86_64-linux") nil;
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
