{ inputs, ... }:
{
  nixpkgs.overlays = [
    inputs.neovim-nightly-overlay.overlay

    (final: prev: {
      vimPlugins = prev.vimPlugins // {
        nvim-treesitter= prev.vimPlugins.nvim-treesitter.overrideAttrs (old: {
          src = prev.fetchFromGitHub {
            owner = "nvim-treesitter"; 
            repo = "nvim-treesitter"; 
            rev = "d2b78324f2191db72e9bc063ff435278c36bf06b";
            hash = "sha256-T5R9/xmK+ttCGwS3X6sYEZDy+ppN1qxcJbytNftBgsw=";
          };
        });
      };
    })      
  ];

  networking.firewall.checkReversePath = false;

  programs.command-not-found.enable = false;
}
