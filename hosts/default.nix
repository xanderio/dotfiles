{ inputs, self, ... }:
{
  flake = {
    colmena =
      let
        inherit (inputs.nixpkgs) lib;

        isDir = _name: type: type == "directory";

        hostDirs = builtins.attrNames
          (lib.filterAttrs isDir
            (builtins.readDir ./.)
          );

        hosts = lib.genAttrs hostDirs (name: {
          imports = [
            (./. + "/${name}")
          ];
        });

      in
      {
        meta = {
          nixpkgs = import inputs.nixos-small {
            system = "x86_64-linux";
          };

          nodeNixpkgs = lib.genAttrs [ "hex" "vger" ]
            (_: import inputs.nixpkgs {
              system = "x86_64-linux";
            });

          specialArgs = {
            inherit (import "${self}/home/profiles" inputs) homeImports;
            inherit inputs;
          } // inputs;
        };

        defaults = {
          imports = [
            ../modules/minimal.nix
            ../modules/ntfy.nix
            inputs.home-manager.nixosModules.home-manager
            inputs.agenix.nixosModules.default
            inputs.nix-index-database.nixosModules.nix-index
            inputs.mms.module
            { services.modded-minecraft-servers.eula = true; }
            inputs.disko.nixosModules.disko
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
              };
            }
          ];
        };
      } // hosts;

    diskoConfigurations = {
      hex = import ./hex/disko.nix;
      vetinari = import ./vetinari/disko.nix;
    };
    nixosConfigurations = (inputs.colmena.lib.makeHive self.outputs.colmena).nodes;
  };
}
