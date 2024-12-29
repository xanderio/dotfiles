{ pkgs, inputs, ... }:
let 
  neovim = inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.neovim-server.extend {
    nixpkgs.pkgs = pkgs;
  };
in 
{
  home.packages = [
    neovim 
  ] ++ neovim.config.extraPackages;
}
