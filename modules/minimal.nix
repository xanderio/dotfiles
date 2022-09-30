{ pkgs, inputs, ... }:
{
  nixpkgs.overlays = [
    inputs.self.overlays.default

    inputs.neovim-nightly-overlay.overlay
    inputs.nix-minecraft.overlay
    inputs.fenix.overlay
  ];

  networking.firewall.checkReversePath = false;
}
