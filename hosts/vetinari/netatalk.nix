{ config, ... }:
{
  networking.firewall.allowedTCPPorts = [ config.services.netatalk.port ];
  services.borgbackup.jobs.backup.exclude = [ "/var/lib/timemachine" ];
  systemd.services.netatalk.serviceConfig = {
    After = [ "avahi-daemon.service" ];
    Wants = [ "avahi-daemon.service" ];
  };
  services.netatalk = {
    enable = true;
    settings = {
      Global = {
        "mimic model" = "TimeCapsule6,106";
      };
      paperless = {
        path = "${config.services.paperless.mediaDir}/documents/originals";
        "valid users" = "xanderio";
      };
      paperless-consume = {
        path = "${config.services.paperless.consumptionDir}";
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
