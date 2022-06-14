{ pkgs, ... }: {
  services.blueman-applet.enable = true;

  systemd.user.services.iwgtk = {
    Unit = {
      Description = "Iwgtk applet";
      Requires = [ "tray.target" ];
      After = [ "graphical-session-pre.target" "tray.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.iwgtk}/bin/iwgtk --indicators";
    };
  };
}
