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
    nixpkgs-unstable.url = github:NixOs/nixpkgs/nixpkgs-unstable;
  };

  outputs =
    { self
    , nixpkgs
    , nixos-hardware
    , home-manager
    , ...
    } @ inputs:
    let
      system = "x86_64-linux";

      overlays = import ./overlays {
        inherit pkgs inputs;
      };

      pkgs = import nixpkgs {
        inherit system overlays;
        config.allowUnfree = true;
      };
      lib = import ./lib { inherit nixpkgs home-manager pkgs overlays system inputs; };
    in
    {
      devShells."${system}".default = pkgs.mkShellNoCC {
        buildInputs = [ pkgs.colmena ];
      };
      nixosConfigurations =
        let
        in
        {
          vger = lib.mkHost {
            name = "vger";
            modules = [
              nixos-hardware.nixosModules.lenovo-thinkpad-t480s
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  sharedModules = import ./modules;
                  users.xanderio = import ./home.nix;
                };
              }
            ];
          };
        };
      colmena =
        import
          ./hive.nix
          { inherit inputs overlays; };
    };
}
