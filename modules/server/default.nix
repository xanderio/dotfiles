{
  imports = [
    ../common
    ./backup.nix
    ./node_exporter.nix
    ./nginx.nix
    ./wireguard.nix
  ];

  zramSwap.enable = true;

  networking = {
    domain = "xanderio.de";
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withRuby = false;
    withPython3 = false;
  };

  deployment.tags = [ "server" ];

  documentation.nixos.enable = false;
}
