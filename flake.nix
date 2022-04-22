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
                  users.xanderio = {
                    imports = [ ./home.nix ];
                  } // {
                    programs.git.signing.key = "alex@xanderio.de";
                  };
                };
              }
            ];
          };
          heracles = lib.mkHost
            {
              name = "heracles";
              modules = [
                nixos-hardware.nixosModules.lenovo-thinkpad-p14s-amd-gen2
                home-manager.nixosModules.home-manager
                {
                  home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    users.xanderio = {
                      imports = [ ./home.nix ];
                    } //
                    {
                      programs.git = nixpkgs.lib.mkForce {
                        signing = {
                          key = "0x3ABD985B2004F8E6";
                          signByDefault = true;
                        };
                        userEmail = "alexander.sieg@binary-butterfly.de";
                      };
                    };
                  };
                }
              ];
            };
        };
      colmena = import
        ./hive.nix
        { inherit inputs; };
    };
}
