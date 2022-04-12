{ pkgs, ... }:
{
  programs.mako = {
    enable = true;

    margin = "17,5";
    font = "JetBrains Mono";
    defaultTimeout = 20000;
    backgroundColor = "#282a36";
    textColor = "#f8f8f2";
    borderColor = "#282a36";

    extraConfig = ''
      [urgency=low]
      border-color=#282a36

      [urgency=normal]
      border-color=#f1fa8c

      [urgency=high]
      border-color=#ff5555

      [mode=do-not-disturb]
      invisible=1
    '';
  };

  systemd.user.services.mako = {
    Unit = {
      Description = "Mako Notification daemon";
      After = [ "graphical-session-pre.target" "tray.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Install = { WantedBy = [ "graphical-session.target" ]; };

    Service = {
      ExecStart = "${pkgs.mako}/bin/mako";
    };
  };
}
