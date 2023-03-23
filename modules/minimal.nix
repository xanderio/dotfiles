{ inputs, ... }:
{
  nixpkgs.overlays = [
    inputs.neovim-nightly-overlay.overlay
    inputs.nix-minecraft.overlay
    inputs.fenix.overlays.default
    inputs.nix-your-shell.overlays.default
    (final: prev: {
      inherit (inputs.nixpkgs-master.legacyPackages.${final.stdenv.system}) elixir-ls;
    })
  ];

  networking.firewall.checkReversePath = false;

  programs.command-not-found.enable = false;
}
