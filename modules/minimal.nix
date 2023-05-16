{ inputs, ... }:
{
  nixpkgs.overlays = [
    inputs.neovim-nightly-overlay.overlay
  ];

  networking.firewall.checkReversePath = false;

  programs.command-not-found.enable = false;
}
