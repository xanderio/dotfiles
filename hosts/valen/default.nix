{
  imports = [
    ./configuration.nix
    ./loki.nix
    ./outline.nix
  ];
  networking.hostName = "valen";
}
