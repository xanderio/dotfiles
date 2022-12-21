{ pkgs, inputs, ... }:
{
  nixpkgs.overlays = [
    inputs.neovim-nightly-overlay.overlay
    inputs.nix-minecraft.overlay
    inputs.fenix.overlays.default
    (final: prev: {
      httpie = inputs.nixpkgs-master.legacyPackages.${final.stdenv.system}.httpie;
    })
  ];

  networking.firewall.checkReversePath = false;
}
