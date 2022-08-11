{ ... }: {
  xdg.configFile."nix/nix.conf".source = ./nix.conf;
  nixpkgs.config = import ./config.nix;
}
