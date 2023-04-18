{ inputs, ... }:
{
  nixpkgs.overlays = [
    inputs.neovim-nightly-overlay.overlay
    inputs.nix-minecraft.overlay
    inputs.fenix.overlays.default
    inputs.nix-your-shell.overlays.default

    (final: prev: {
      xdg-desktop-portal-wlr = prev.xdg-desktop-portal-wlr.overrideAttrs (oldAttrs: rec {
        version = "0.7.0";
        src = final.fetchFromGitHub {
          owner = "emersion";
          repo = "xdg-desktop-portal-wlr";
          rev = "v${version}";
          sha256 = "sha256-EwBHkXFEPAEgVUGC/0e2Bae/rV5lec1ttfbJ5ce9cKw=";
        };

        patches = [];
      });
    })

  ];

  networking.firewall.checkReversePath = false;

  programs.command-not-found.enable = false;
}
