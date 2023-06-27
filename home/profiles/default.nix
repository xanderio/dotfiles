inputs:
let
  inherit (inputs) self;

  sharedModules = [
    ../.
    ../shell
    inputs.nix-index-database.hmModules.nix-index
  ];

  defArg = {
    pkgs = self.pkgs.x86_64-linux;
  };
  mkHome = args: inputs.home-manager.lib.homeManagerConfiguration (defArg // args);

  homeImports = {
    "xanderio@vger" = sharedModules ++ [ ./vger ];
    "xanderio@hex" = sharedModules ++ [ ./hex ];
    server = sharedModules ++ [ ./server ];
  };
in
{
  inherit homeImports;
  homeConfigurations = {
    "xanderio@vger" = mkHome { modules = homeImports."xanderio@vger"; };
    "xanderio@hex" = mkHome { modules = homeImports."xanderio@hex"; };
    server = mkHome { modules = homeImports.server; };
    ook = inputs.home-manager.lib.homeManagerConfiguration {
       pkgs = import inputs.nixpkgs { 
         system = "aarch64-darwin";
       };
       modules = sharedModules ++ [
         ./ook
       ];
    };
  };
}
