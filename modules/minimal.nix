{ pkgs, inputs, ... }:
{
  nixpkgs.overlays = [
    inputs.neovim-nightly-overlay.overlay
    inputs.nix-minecraft.overlay
    inputs.fenix.overlays.default
    inputs.nix-your-shell.overlays.default
    (final: prev: {
      inherit (inputs.nixos-small.legacyPackages.${final.stdenv.system}) fish;
      inherit (inputs.nixos-small.legacyPackages.${final.stdenv.system}) bibata-cursors clickgen;
      nil = prev.nil.overrideAttrs (old: {
        src = prev.fetchFromGitHub {
          owner = "oxalica";
          repo = "nil";
          rev = "b5797b481ae87de5d4d99791e08400b9ac5a43a5";
          sha256 = "sha256-5ABNUoXmlGjwkqGJ3YhUeQarcu0qwH7Al2tiuR/Pzoc=";
        };
      });
    })
  ];

  networking.firewall.checkReversePath = false;
}
