inputs:
let
  inherit (inputs) self;

  sharedModules = [
    ../.
    ../shell
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
  };
}