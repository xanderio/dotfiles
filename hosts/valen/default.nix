{ config, ... }: {
  imports = [
    ./headscale.nix
    ./configuration.nix
    ./loki.nix
    ./outline.nix
  ];
  networking.hostName = "valen";

  services.grocy = {
    enable = true;
    hostName = "grocy.xanderio.de";
    settings = {
      currency = "EUR";
      calendar.firstDayOfWeek = 1;
    };
  };
}
