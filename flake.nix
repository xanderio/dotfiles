{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-minecraft = {
      url = "github:Infinidoge/nix-minecraft";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nil = {
      url = "github:oxalica/nil";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    colmena = {
      url = "github:zhaofengli/colmena";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , ...
    } @ inputs:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
      };
    in
    {
      pkgs.${system} = pkgs;
      formatter."${system}" = pkgs.nixpkgs-fmt;
      devShells."${system}".default = pkgs.mkShellNoCC {
        buildInputs = [ pkgs.colmena inputs.agenix.packages.${system}.agenix ];
      };
      packages."${system}" = import ./pkgs { callPackage = pkgs.callPackage; };
      overlays.default = final: prev: (import ./pkgs { inherit (prev) callPackage; });

      nixosConfigurations = import ./hosts inputs;

      colmena =
        let
          inherit (inputs.nixpkgs) lib;
          hosts = lib.filterAttrs (name: value: lib.hasAttrByPath [ "config" "deployment" ] value) self.nixosConfigurations;
        in
        {
          meta = {
            specialArgs = { inherit inputs; };
            nixpkgs = pkgs;
          };
        } // builtins.mapAttrs
          (name: value: {
            nixpkgs.system = value.config.nixpkgs.system;
            imports = value._module.args.modules;
          })
          hosts;
    };
}
