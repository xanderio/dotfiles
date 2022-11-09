{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-small.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "flake-utils";
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
      inputs.flake-utils.follows = "flake-utils";
    };
    deploy-rs.url = "github:xanderio/deploy-rs";
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    website = {
      url = "github:xanderio/website";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    graftify = {
      url = "git+https://git.xanderio.de/xanderio/graftify.git";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = { self, nixpkgs, flake-utils, ... } @ inputs:
    flake-utils.lib.eachSystem [ "x86_64-linux" ]
      (system:
        let
          pkgs = import nixpkgs { inherit system; };
          inherit (pkgs) lib;
        in
        rec {
          inherit pkgs;
          formatter = pkgs.nixpkgs-fmt;
          devShells.default = pkgs.mkShellNoCC {
            buildInputs = [
              inputs.deploy-rs.packages."${system}".deploy-rs
              inputs.agenix.packages."${system}".agenix
            ];
          };
          checks = lib.foldl lib.recursiveUpdate { } [
            (lib.mapAttrs' (name: value: { name = "deploy-${name}"; inherit value; }) (inputs.deploy-rs.lib.${system}.deployChecks self.deploy))
            (lib.mapAttrs' (name: value: { name = "devShell-${name}"; inherit value; }) devShells)
          ];
        }) //
    {
      deploy = import ./hosts/deploy.nix inputs;
      nixosConfigurations = import ./hosts inputs;
      herculesCI.ciSystems = [ "x86_64-linux" ];
    };
}
