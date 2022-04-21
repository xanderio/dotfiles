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
      system = "x86_64-linux";

      overlays = import ./overlays {
        inherit pkgs inputs;
      };

      pkgs = import nixpkgs {
        inherit system overlays;
        config.allowUnfree = true;
      };
    in
    {
      devShells."${system}".default = pkgs.mkShellNoCC {
        buildInputs = [ pkgs.colmena ];
      };
      # replace 'joes-desktop' with your hostname here.
      nixosConfigurations.vger = nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        specialArgs = inputs;
        modules = [
          ./hosts/vger/configuration.nix
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
      nixosConfigurations.heracles = nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        specialArgs = inputs;
        modules = [
          ./hosts/heracles/configuration.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-p14s-amd-gen2
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
      colmena = import ./hive.nix { inherit inputs; };
    };
}
