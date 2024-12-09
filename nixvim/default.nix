{
  flake = {
    nixvimModules = {
      server.imports = [ ./server.nix ];
      desktop.imports = [ ./desktop.nix ];
    };
  };
}
