{ pkgs, nixosConfig, ... }:
{
  services.blueman-applet.enable = true;
  systemd.user.services._1password = {
    Unit = {
      Description = "1Password";
      Requires = [ "tray.target" ];
      After = [
        "graphical-session-pre.target"
        "tray.target"
      ];
      PartOf = [ "graphical-session.target" ];
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${nixosConfig.programs._1password-gui.package}/bin/1password --silent";
    };
  };
}
