{config, ...}: {
  networking.firewall.allowedTCPPorts = [ config.services.netatalk.port ];
  services.netatalk = {
    enable = true;
    settings = {
      Global = {
        "mimic model" = "TimeCapsule6,106";
      };
      TimeMachine = {
        path = "/var/lib/timemachine";
        "valid users" = "xanderio";
        "time machine" = "yes";
      };
    };
  };
}
