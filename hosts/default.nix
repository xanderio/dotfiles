{ inputs, self, ... }:
let
  sharedModules = [
    ../modules/minimal.nix
    ../modules/ntfy.nix
    { _module.args = { inherit inputs; }; }
    inputs.nix-minecraft.nixosModules.minecraft-servers
    inputs.home-manager.nixosModules.home-manager
    inputs.agenix.nixosModules.default
    inputs.graftify.nixosModules.graftify
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
      };
    }
  ];

  extraModules = [ ];

  inherit (inputs.nixpkgs.lib) nixosSystem;
  inherit (import "${self}/home/profiles" inputs) homeImports;
in
{
  flake.nixosConfigurations = {
    vger = nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./vger
        ../modules/laptop
        inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480s
        { home-manager.users.xanderio.imports = homeImports."xanderio@vger"; }
      ]
      ++ sharedModules;
    };
    hex = nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hex
        ../modules/laptop
        inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14
        { home-manager.users.xanderio.imports = homeImports."xanderio@hex"; }
      ]
      ++ sharedModules;
    };

    delenn = inputs.nixos-small.lib.nixosSystem
      {
        inherit extraModules;
        system = "x86_64-linux";
        modules = [
          ./delenn
          ../modules/server
        ]
        ++ sharedModules;
      };

    valen = inputs.nixos-small.lib.nixosSystem
      {
        inherit extraModules;
        system = "x86_64-linux";
        modules = [
          ./valen
          ../modules/server
        ]
        ++ sharedModules;
      };

    block = inputs.nixos-small.lib.nixosSystem
      {
        inherit extraModules;
        system = "x86_64-linux";
        modules = [
          ./block
          ../modules/server
        ]
        ++ sharedModules;
      };
  };
}
