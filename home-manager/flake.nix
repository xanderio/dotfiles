{
  description = "Home Manager configuration of xanderio";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-21.11";
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
      nixos-stable-overlay = final: prev: {
        nixos-stable = import inputs.nixpkgs-stable {
          system = prev.system;
        };
      };
      overlays = [
        inputs.neovim-nightly-overlay.overlay
        nixos-stable-overlay
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
              ./modules/taskwarrior.nix
              ./modules/firefox.nix
              ./modules/chromium.nix
              ./modules/git.nix
              ./modules/fish.nix
              ./modules/starship.nix
              ./modules/foot.nix
              ./modules/misc.nix
              ./modules/sway.nix
              ./modules/neovim.nix
              ./modules/nix-utilities.nix
              ./modules/home-manager.nix
              ./modules/games.nix
              ./modules/gtk.nix
              ./modules/ssh.nix
              ./modules/fonts.nix
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
