{ pkgs, ... }:
{
  services.kanshi =
    let
      swaymsg = "${pkgs.sway}/bin/swaymsg";
      notify-send = "${pkgs.libnotify}/bin/notify-send";
      docked-script = pkgs.writeScript "kanshi-docked" ''
        #! ${pkgs.runtimeShell}
        ${swaymsg} workspace 1, move workspace to output '"Lenovo Group Limited P27h-20 V906K7HR"'
        ${swaymsg} workspace 2, move workspace to output '"Lenovo Group Limited P27h-20 V906K7HR"'
        ${swaymsg} workspace 3, move workspace to output '"Lenovo Group Limited P27h-20 V906K7HR"'
        ${swaymsg} workspace 4, move workspace to output '"Lenovo Group Limited P27q-20 V9064YE0"'

        ${swaymsg} workspace 1
        systemctl --user restart waybar.service
        ${notify-send} -u low "switched to docked display mode"
      '';
      undocked-script = pkgs.writeScript "kanshi-undocked" ''
        #! ${pkgs.runtimeShell}
        systemctl --user restart waybar.service
        ${notify-send} -u low "switched to undocked display mode"
      '';
    in
    {
      enable = true;

      profiles = {
        undocked = {
          exec = [ "${undocked-script}" ];
          outputs = [
            {
              criteria = "eDP-1";
              position = "0,0";
            }
          ];
        };
        docked = {
          exec = [ "${docked-script}" ];
          outputs = [
            {
              criteria = "eDP-1";
              position = "0,1440";
            }
            {
              criteria = "Lenovo Group Limited P27h-20 V906K7HR";
              status = "enable";
              mode = "2560x1440";
              position = "0,0";
            }
            {
              criteria = "Lenovo Group Limited P27q-20 V9064YE0";
              status = "enable";
              mode = "2560x1440";
              position = "2560,0";
            }
          ];
        };
      };
    };
}
