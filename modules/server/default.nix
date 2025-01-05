{ inputs, pkgs, ... }:
let
  neovim = inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.neovim-server.extend {
    nixpkgs.pkgs = pkgs;
  };
in
{
  imports = [
    ../common
    ./backup.nix
    ./node_exporter.nix
    ./nginx.nix
    ./wireguard.nix
    ../matrix-authentication-service
  ];

  zramSwap.enable = true;

  networking = {
    domain = "xanderio.de";
  };

  environment.variables = {
    EDITOR = "nvim";
  };

  environment.systemPackages = [
    neovim
  ] ++ neovim.config.extraPackages;

  deployment.tags = [ "server" ];

  documentation.nixos.enable = false;
}
