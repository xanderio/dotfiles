{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixos-small.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    flake-parts.url = "github:hercules-ci/flake-parts";
    colmena.url = "github:zhaofengli/colmena";
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = 
        {
          nixpkgs.follows = "nixpkgs";
          flake-parts.follows = "flake-parts";
        };
    };
    sops = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-review.url = "github:Mic92/nixpkgs-review";
    nixpkgs-review.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-review.inputs.flake-parts.follows = "flake-parts";
    sops-to-age.url = "github:Mic92/ssh-to-age";
    sops-to-age.inputs.flake-parts.follows = "flake-parts";
    sops-to-age.inputs.nixpkgs.follows = "nixpkgs";
    website = {
      url = "github:xanderio/website";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    authentik = {
      url = "github:nix-community/authentik-nix";
      inputs."flake-parts".follows = "flake-parts";
    };
    draupnir.url = "github:TheArcaneBrony/nixpkgs?ref=module/draupnir";
    draupnir-update.url = "github:xanderio/nixpkgs?ref=push-pwzyqzymowns";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      debug = true;
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      imports = [
        ./hosts
        ./darwin
        ./checks
        ./nixvim
      ];
      flake = {
        inherit (import ./home/profiles inputs) homeConfigurations;
      };
      perSystem =
        { pkgs, inputs', ... }:
        {
          formatter = pkgs.nixfmt-rfc-style;
          devShells.default = pkgs.mkShellNoCC {
            buildInputs = [
              inputs'.colmena.packages.colmena
              pkgs.sops
              inputs'.sops-to-age.packages.ssh-to-age
            ];
          };
        };
    };
}
