{ config, ... }: {
  imports = [
    ./headscale.nix
    ./gitea.nix
    ./configuration.nix
    ./loki.nix
    ./outline.nix
  ];
  networking.hostName = "valen";

  age.secrets.graftify.file = ../../secrets/graftify.age;
  services.graftify = {
    enable = true;
    envFile = config.age.secrets.graftify.path;
  };
}
