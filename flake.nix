{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    nixos-hardware.url = github:NixOS/nixos-hardware;
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = github:nix-community/neovim-nightly-overlay;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    taplo-update.url = github:xanderio/nixpkgs/taplo-cli-0.6.1;
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, ... }@inputs:
    let
      overlays = [
        inputs.neovim-nightly-overlay.overlay
        (final: prev:
          let
            nixpkgs = import inputs.taplo-update { system = prev.system; };
          in
          {
            taplo-cli = nixpkgs.taplo-cli;
          })
        (final: prev: {
          nvim-ts-grammars = prev.callPackage ./home/pkgs/nvim-ts-grammars { };
          timewarrior-hook = prev.callPackage ./home/pkgs/timewarrior-hook { };
        })
      ];
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system overlays;
        config.allowUnfree = true;
      };
    in
    {
      # replace 'joes-desktop' with your hostname here.
      nixosConfigurations.vger = nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        specialArgs = inputs;
        modules = [
          ./vger/configuration.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-t480s
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.xanderio = import ./home;
            };
            nixpkgs = {
              inherit overlays;
              config.allowUnfree = true;
            };
          }
        ];
      };
    };
}
