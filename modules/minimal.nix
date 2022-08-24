{ pkgs, inputs, ... }:
{
  nixpkgs.overlays = [
    inputs.self.overlays.default

    inputs.neovim-nightly-overlay.overlay
    inputs.nix-minecraft.overlay
    inputs.fenix.overlay
    (final: prev: { inherit (inputs.nil.packages.${prev.system}) nil; })
  ];

  networking.firewall.checkReversePath = "loose";
}
