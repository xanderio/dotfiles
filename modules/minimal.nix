{ inputs, ... }:
{
  nixpkgs.overlays = [
    inputs.neovim-nightly-overlay.overlay
    inputs.nix-minecraft.overlay
    inputs.fenix.overlays.default
    inputs.nix-your-shell.overlays.default

  ];

  networking.firewall.checkReversePath = false;

  programs.command-not-found.enable = false;
}
