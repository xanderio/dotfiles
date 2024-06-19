{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = ./style.css;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 25;
        spacing = 0;
        modules-left = [
          "sway/workspaces"
          "sway/mode"
        ];
        modules-center = [ "sway/window" ];
        modules-right = [
          "network"
          "idle_inhibitor"
          "pulseaudio"
          "battery"
          "clock"
          "tray"
        ];
        "sway/workspaces" = {
          disable-scroll = true;
          disable-markup = false;
        };
        "sway/window" = {
          max-length = 50;
          icon = false;
        };
        tray.spacing = 10;
        clock = {
          locale = "de_DE.utf8";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt>{calendar}</tt>";
          format-alt = "{:%Y-%m-%d}";
        };
        network = {
          interface = "wlan0";
          format = "{ifname}";
          format-wifi = "{essid} ({signalStrength}%) ";
          tooltip-format = "{ifname} via {gwaddr} ";
          tooltip-format-wifi = "{essid} ({signalStrength}%) ";
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };
        pulseaudio =
          let
            pavucontrol = "${pkgs.pavucontrol}/bin/pavucontrol";
          in
          {
            format = "{volume}%";
            on-click = "${pavucontrol}";
          };
        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };
      };
    };
  };
  xdg.configFile."waybar/base16-dracula.css".source = ./base16-dracula.css;
}
