{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay/167ec1a6047ef9051c709e4115fb5f4f90c5febd";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-minecraft = {
      url = "github:Infinidoge/nix-minecraft";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    deploy-rs = {
      url = "git+https://git.xanderio.de/xanderio/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    graftify = {
      url = "git+https://git.xanderio.de/xanderio/graftify.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, ... } @ inputs:
    flake-utils.lib.eachSystem [ "x86_64-linux" ]
      (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          pkgs = pkgs;
          formatter = pkgs.nixpkgs-fmt;
          devShells.default = pkgs.mkShellNoCC {
            buildInputs = [
              inputs.deploy-rs.packages."${system}".deploy-rs
              inputs.agenix.packages."${system}".agenix
            ];
          };
          packages = import ./pkgs { callPackage = pkgs.callPackage; };
        }) //
    {
      overlays.default = final: prev: (import ./pkgs { inherit (prev) callPackage; });

      deploy = import ./hosts/deploy.nix inputs;
      nixosConfigurations = import ./hosts inputs;
      checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) inputs.deploy-rs.lib;
    };
}
