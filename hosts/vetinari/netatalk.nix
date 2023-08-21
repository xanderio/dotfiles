{config, ...}: {
  networking.firewall.allowedTCPPorts = [ config.services.netatalk.port ];
  services.netatalk = {
    enable = true;
    settings = {
      Global = {
        "mimic model" = "TimeCapsule6,106";
      };
      paperless = {
        path = "${config.services.paperless.dataDir}";
        "valid users" = "xanderio";
      };
      media = {
        path = "/media";
        "valid users" = "xanderio";
      };
      TimeMachine = {
        path = "/var/lib/timemachine";
        "valid users" = "xanderio";
        "time machine" = "yes";
      };
    };
  };
}
