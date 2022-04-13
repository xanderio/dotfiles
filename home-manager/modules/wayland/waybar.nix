{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = ../../configs/waybar/style.css;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 25;
        width = 2560;
        spacing = 0;
        modules-left = [ "sway/workspaces" "sway/mode" ];
        modules-center = [ "sway/window" ];
        modules-right = [ "custom/spt" "idle_inhibitor" "pulseaudio" "battery" "clock" "tray" ];
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
            format = "{icon} {volume}%";
            on-click = "${pavucontrol}";
          };
        "custom/spt" =
          let
            spt = "${pkgs.spotify-tui}/bin/spt";
            pgrep = "${pkgs.busybox}/bin/pgrep";
          in
          {
            format = "{}";
            max-length = 40;
            interval = 10;
            exec = "${spt} pb --status";
            exec-if = "${pgrep} spt";
            on-click = "${spt} pb --toggle";
            escape = true;
          };
        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-icons = [ "" "" "" "" "" ];
        };
      };
    };
  };
  xdg.configFile."waybar/base16-dracula.css".source = ../../configs/waybar/base16-dracula.css;
}
