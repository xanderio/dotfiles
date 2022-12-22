{ pkgs, inputs, ... }:
{
  nixpkgs.overlays = [
    inputs.neovim-nightly-overlay.overlay
    inputs.nix-minecraft.overlay
    inputs.fenix.overlays.default
    (final: prev: {
      httpie = inputs.nixpkgs-master.legacyPackages.${final.stdenv.system}.httpie;
      element-desktop = inputs.nixpkgs-master.legacyPackages.${final.stdenv.system}.element-desktop;
    })
  ];

  networking.firewall.checkReversePath = false;
}
