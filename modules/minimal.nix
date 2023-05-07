{ inputs, ... }:
{
  nixpkgs.overlays = [
    inputs.neovim-nightly-overlay.overlay
    inputs.fenix.overlays.default
  ];

  networking.firewall.checkReversePath = false;

  programs.command-not-found.enable = false;
}
