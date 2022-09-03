inputs:
let
  inherit (inputs) self;
  sharedModules = [
    ../modules/minimal.nix
    ../modules/ntfy.nix
    { _module.args = { inherit inputs; }; }
    inputs.nix-minecraft.nixosModules.minecraft-servers
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
      };
    }
  ];

  extraModules = [
    inputs.colmena.nixosModules.deploymentOptions
  ];

  inherit (inputs.nixpkgs.lib) nixosSystem;
  inherit (import "${self}/home/profiles" inputs) homeImports;
in
{
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

  delenn = nixosSystem {
    inherit extraModules;
    system = "x86_64-linux";
    modules = [
      ./delenn
      ../modules/server
    ]
    ++ sharedModules;
  };

  valen = nixosSystem {
    inherit extraModules;
    system = "x86_64-linux";
    modules = [
      ./valen
      ../modules/server
    ]
    ++ sharedModules;
  };

  block = nixosSystem {
    inherit extraModules;
    system = "x86_64-linux";
    modules = [
      ./block
      ../modules/server
    ]
    ++ sharedModules;
  };
}
