{ inputs, ... }:
{
  nixpkgs.overlays = [
    inputs.neovim-nightly-overlay.overlay
    inputs.nix-minecraft.overlay
    inputs.fenix.overlays.default
    inputs.nix-your-shell.overlays.default
    (final: prev: {
      inherit (inputs.nixos-small.legacyPackages.${final.stdenv.system}) fish;
      inherit (inputs.nixos-small.legacyPackages.${final.stdenv.system}) bibata-cursors clickgen;
    })
  ];

  networking.firewall.checkReversePath = false;

  programs.command-not-found.enable = false;
}
