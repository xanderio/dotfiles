{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixos-stable.url = "github:NixOS/nixpkgs/nixos-24.05-small";
    nixos-small.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    flake-parts.url = "github:hercules-ci/flake-parts";
    colmena.url = "github:zhaofengli/colmena/direct-flake-eval";
    colmena.inputs."nixpkgs".follows = "nixpkgs";
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
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
    authentik = {
      url = "github:nix-community/authentik-nix";
      inputs."flake-parts".follows = "flake-parts";
    };
    nix-fast-build = {
      url = "github:Mic92/nix-fast-build";
      inputs."nixpkgs".follows = "nixpkgs";
      inputs."flake-parts".follows = "flake-parts";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      imports = [
        ./hosts
        ./darwin
        ./checks
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
              (inputs'.colmena.packages.colmena.overrideAttrs (old: {
                patches = (
                  old.patches or [ ]
                  ++ [
                    (pkgs.fetchpatch {
                      url = "https://github.com/zhaofengli/colmena/pull/233.patch";
                      hash = "sha256-uwL3u0gO708bzV2NV8sTt10WHaCL3HykJNqSZNp9EtA=";
                    })
                  ]
                );
              }))

              pkgs.sops
              inputs'.sops-to-age.packages.ssh-to-age
            ];
          };
        };
    };
}
