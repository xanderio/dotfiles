{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixos-small.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    flake-parts.url = "github:hercules-ci/flake-parts";
    colmena.url = "github:zhaofengli/colmena";
    colmena.inputs."nixpkgs".follows = "nixpkgs";
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-flake.url = "github:neovim/neovim?dir=contrib";
    neovim-flake.inputs.nixpkgs.follows = "nixpkgs-master";
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.neovim-flake.follows = "neovim-flake";
    };
    mms = {
      url = "github:mkaito/nixos-modded-minecraft-servers";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    next-ls.url = "github:elixir-tools/next-ls";
    next-ls.inputs."nixpkgs".follows = "nixpkgs";
    sops-to-age.url = "github:Mic92/ssh-to-age";
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
    norg.url = "github:nvim-neorg/tree-sitter-norg/dev";
    norg.flake = false;
    norg-meta.url = "github:nvim-neorg/tree-sitter-norg-meta";
    norg-meta.flake = false;

    neorg = {
      url = "github:nvim-neorg/neorg";
      flake = false;
    };
    neorg-telescope = {
      url = "github:nvim-neorg/neorg-telescope";
      flake = false;
    };
    authentik = {
      url = "github:nix-community/authentik-nix";
      inputs."nixpkgs".follows = "nixos-small";
      inputs."flake-parts".follows = "flake-parts";
    };
    nix-fast-build = {
      url = "github:Mic92/nix-fast-build"; 
      inputs."nixpkgs".follows = "nixpkgs";
      inputs."flake-parts".follows = "flake-parts";
    };
  };

  outputs = inputs@{ flake-parts, self, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-darwin" ];
      imports = [
        ./hosts
        ./darwin
      ];
      flake = {
        inherit (import ./home/profiles inputs) homeConfigurations;
      };
      perSystem = { pkgs, lib, inputs', self', system, ... }: {
        formatter = pkgs.nixpkgs-fmt;
        devShells.default = pkgs.mkShellNoCC {
          buildInputs = [
            pkgs.colmena
            pkgs.sops
            inputs'.sops-to-age.packages.ssh-to-age
          ];
        };
      };
    };
}
