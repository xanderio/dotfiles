{
  description = "Home Manager configuration of xanderio";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-staging-next.url = "github:nixos/nixpkgs/staging-next";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, home-manager, ... }@inputs:
    let
      firefox-overlay = final: prev: {
        firefox-wayland = (import inputs.nixpkgs-staging-next {
          system = prev.system;
        }).pkgs.firefox-wayland;
      };
      overlays = [
        inputs.neovim-nightly-overlay.overlay
        firefox-overlay
        (final: prev: {
          nvim-ts-grammars = prev.callPackage ./pkgs/nvim-ts-grammars { };
          timewarrior-hook = prev.callPackage ./pkgs/timewarrior-hook.nix { };
        })
      ];
    in
    {
      homeConfigurations = {
        vger = home-manager.lib.homeManagerConfiguration {
          # Specify the path to your home configuration here
          configuration = { pkgs, config, ... }: {
            xdg.configFile."nix/nix.conf".source = ./configs/nix/nix.conf;
            nixpkgs.config = import ./configs/nix/config.nix;
            nixpkgs.overlays = overlays;
            imports = [
              ./modules/chromium.nix
              ./modules/darcs.nix
              ./modules/firefox.nix
              ./modules/fish.nix
              ./modules/fonts.nix
              ./modules/foot.nix
              ./modules/games.nix
              ./modules/git.nix
              ./modules/gtk.nix
              ./modules/home-manager.nix
              ./modules/misc.nix
              ./modules/neovim.nix
              ./modules/nix-utilities.nix
              ./modules/rust.nix
              ./modules/ssh.nix
              ./modules/starship.nix
              ./modules/taskwarrior.nix
              ./modules/wayland
            ];
          };
          system = "x86_64-linux";
          homeDirectory = "/home/xanderio";
          username = "xanderio";
          stateVersion = "22.05";
        };
      };
      vger = self.homeConfigurations.vger.activationPackage;
    };
}
