{ pkgs, inputs, ... }:
{
  nixpkgs.overlays = [
    inputs.neovim-nightly-overlay.overlay
    inputs.nix-minecraft.overlay
    inputs.fenix.overlays.default
    (final: prev: {
      inherit (inputs.nixos-small.legacyPackages.${final.stdenv.system}) fish;
    })
  ];

  networking.firewall.checkReversePath = false;
}
