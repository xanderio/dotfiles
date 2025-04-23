{ inputs, self, ... }:
{
  flake = {
    colmena =
      let
        inherit (inputs.nixpkgs) lib;

        isDir = _name: type: type == "directory";

        hostDirs = builtins.attrNames (lib.filterAttrs isDir (builtins.readDir ./.));

        hosts = lib.genAttrs hostDirs (name: {
          imports = [ (./. + "/${name}") ];
        });

      in
      {
        meta = {
          nixpkgs = import inputs.nixos-small { system = "x86_64-linux"; };

          nodeNixpkgs =
            {
              "carrot" = import inputs.nixos-small { system = "aarch64-linux"; };
            }
            // lib.genAttrs [
              "hex"
              "vger"
            ] (_: import inputs.nixpkgs { system = "x86_64-linux"; });

          specialArgs = {
            inherit (import "${self}/home/profiles" inputs) homeImports;
            inherit inputs;
          } // inputs;
        };

        defaults = {
          imports = [
            ../profiles/base
            ../modules/minimal.nix
            ../modules/ntfy.nix
            ../modules/sops
            inputs.home-manager.nixosModules.home-manager
            inputs.nix-index-database.nixosModules.nix-index
            inputs.disko.nixosModules.disko
            inputs.sops.nixosModules.sops
            {
              home-manager = {
                extraSpecialArgs = { inherit inputs; };
                useGlobalPkgs = true;
                useUserPackages = true;
              };
            }
          ];
        };
      }
      // hosts;

    diskoConfigurations = {
      hex = import ./hex/disko.nix;
      vetinari = import ./vetinari/disko.nix;
    };
    colmenaHive = inputs.colmena.lib.makeHive self.outputs.colmena;
    nixosConfigurations = self.colmenaHive.nodes;
  };
}
