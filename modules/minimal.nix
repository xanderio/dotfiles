{ inputs, ... }:
{
  nixpkgs.overlays = [
    inputs.neovim-nightly-overlay.overlay
    inputs.nix-minecraft.overlay
    inputs.fenix.overlays.default
    inputs.nix-your-shell.overlays.default
    (final: prev: {
      inherit (inputs.nixpkgs-master.legacyPackages.${final.stdenv.system}) elixir-ls;

      vimPlugins = prev.vimPlugins // {
        diffview-nvim = prev.vimPlugins.diffview-nvim.overrideAttrs (old: {
          patches = [
            (prev.fetchurl {
              url = "https://patch-diff.githubusercontent.com/raw/sindrets/diffview.nvim/pull/326.diff";
              sha256 = "1zjli1m4yvwjay5qr8cnbv9kwfj724hjrc3ycaxd3iaf0afmw54s";
            })
          ];
        });
      };
    })
  ];

  networking.firewall.checkReversePath = false;

  programs.command-not-found.enable = false;
}
