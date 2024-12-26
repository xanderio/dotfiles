{self, ...}: {
  flake = {
    nixvimModules = {
      server.imports = [ ./server.nix ];
      desktop.imports = [ ./desktop.nix ];
    };
  };
  perSystem = {pkgs, inputs', ...}: {
    packages = {
      neovim = inputs'.nixvim.legacyPackages.makeNixvimWithModule {
        inherit pkgs;
        module = self.nixvimModules.desktop;
      };
      neovim-server = inputs'.nixvim.legacyPackages.makeNixvimWithModule {
        inherit pkgs;
        module = self.nixvimModules.server;
      };
    };
  };
}
