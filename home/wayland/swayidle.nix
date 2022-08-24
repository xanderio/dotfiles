{ pkgs, ... }:
let
  swaylock = "${pkgs.swaylock}/bin/swaylock";
  swaymsg = "${pkgs.sway}/bin/swaymsg";
  pgrep = "${pkgs.busybox}/bin/pgrep";
in
{
  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "${swaylock} -fF";
      }
    ];
    timeouts = [
      {
        timeout = 900;
        command = "${swaylock} -fF";
      }
      {
        timeout = 10;
        command = "if ${pgrep} -x swaylock; then ${swaymsg} \"output * dpms off\"; fi";
        resumeCommand = "${swaymsg} \"output * dpms on\"";
      }
    ];
  };
}
