{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixos-small.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-flake.url = "github:neovim/neovim?dir=contrib";
    neovim-flake.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.neovim-flake.follows = "neovim-flake";
    };
    mms = {
      url = "github:mkaito/nixos-modded-minecraft-servers";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    deploy-rs.url = "github:serokell/deploy-rs";
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    website = {
      url = "github:xanderio/website";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ flake-parts, self, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      imports = [
        ./hosts/deploy.nix
        ./hosts
      ];
      perSystem = { pkgs, lib, inputs', self', system, ... }: {

        formatter = pkgs.nixpkgs-fmt;
        devShells.default = pkgs.mkShellNoCC {
          buildInputs = [
            inputs'.deploy-rs.packages.deploy-rs
            inputs'.agenix.packages.agenix
          ];
        };
        checks = lib.foldl lib.recursiveUpdate { } [
          (lib.mapAttrs' (name: value: { name = "deploy-${name}"; inherit value; }) (inputs.deploy-rs.lib.${system}.deployChecks self.deploy))
          (lib.mapAttrs' (name: value: { name = "devShell-${name}"; inherit value; }) self'.devShells)
        ];
      };
    };
}
