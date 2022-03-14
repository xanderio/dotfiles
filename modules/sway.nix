{ pkgs, lib, config, ... }:
let
  fuzzelOptions = lib.strings.concatStringsSep " " [
    ''--font="JetBrains Mono"''
    "--background-color=282a36ee"
    "--text-color=f8f8f2ff"
    "--selection-color=44475aee"
    "--selection-text-color=ff79c6ff"
    "--border-width=0"
  ];
in
{
  home.packages = with pkgs; [
    swaylock
    wl-clipboard

    bibata-cursors
  ];

  wayland.windowManager.sway = {
    enable = true;
    # use system provided sway version, nixpkgs version is unable to create egl context
    package = null;
    systemdIntegration = true;
    wrapperFeatures.gtk = true;
    config = {
      modifier = "Mod4";
      terminal = "${pkgs.foot}/bin/foot";
      menu = "${pkgs.fuzzel}/bin/fuzzel ${fuzzelOptions}";
      bars = [ ];
      input = {
        "type:keyboard" = {
          xkb_layout = "de(nodeadkeys)";
          xkb_rules = "evdev";
          xkb_options = "caps:escape";
        };
        "type:touchpad" = {
          pointer_accel = "0.4";
          tap = "enabled";
          dwt = "enabled";
        };
        "Elan Touchpad" = {
          events = "disabled";
          pointer_accel = "0.8";
        };
      };
      output = {
        eDP-1 = {
          scale = "1";
          pos = "0 0";
        };
        "*".bg = "~/.background.png fill";
      };
      colors =
        let
          red = "#FF5555";
          blue = "#6272A4";
          white = "#F8F8F2";
          grey = "#BFBFBF";
          darker_grey = "#282A36";
          dark_grey = "#44475A";
        in
        {
          background = "#F8F8F2";
          focused = {
            background = blue;
            border = blue;
            childBorder = blue;
            indicator = blue;
            text = white;
          };
          focusedInactive = {
            background = dark_grey;
            border = dark_grey;
            childBorder = dark_grey;
            indicator = dark_grey;
            text = white;
          };
          placeholder = {
            background = darker_grey;
            border = darker_grey;
            childBorder = darker_grey;
            indicator = darker_grey;
            text = white;
          };
          unfocused = {
            background = darker_grey;
            border = darker_grey;
            childBorder = darker_grey;
            indicator = darker_grey;
            text = grey;
          };
          urgent = {
            background = dark_grey;
            border = red;
            childBorder = red;
            indicator = red;
            text = white;
          };
        };
      keybindings =
        let
          mod = config.wayland.windowManager.sway.config.modifier;
          cfg = config.wayland.windowManager.sway.config;

          makoctl = "${pkgs.mako}/bin/makoctl";
          playerctl = "${pkgs.playerctl}/bin/playerctl";
          pactl = "${pkgs.pulseaudio}/bin/pactl";
          brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";

          grim = "${pkgs.grim}/bin/grim";
          slurp = "${pkgs.slurp}/bin/slurp";
          pngquant = "${pkgs.pngquant}/bin/pngquant";
          wl-copy = "${pkgs.wl-clipboard}/bin/wl-copy";
        in
        lib.mkOptionDefault {
          "${mod}+asciicircum" = "workspace back_and_forth";

          "${mod}+Control+Shift+${cfg.left}" = "move container to output left";
          "${mod}+Control+Shift+${cfg.right}" = "move container to output right";
          "${mod}+Control+Shift+${cfg.up}" = "move container to output up";
          "${mod}+Control+Shift+${cfg.down}" = "move container to output down";

          "${mod}+Control+Shift+Left" = "move container to output left";
          "${mod}+Control+Shift+Right" = "move container to output right";
          "${mod}+Control+Shift+Up" = "move container to output up";
          "${mod}+Control+Shift+Down" = "move container to output down";

          "Alt+Backspace" = "exec ${makoctl} dismiss";
          XF86AudioLowerVolume = "exec ${pactl} set-sink-volume @DEFAULT_SINK@ -5%";
          XF86AudioRaiseVolume = "exec ${pactl} set-sink-volume @DEFAULT_SINK@ +5%";
          XF86AudioMute = "exec ${pactl} set-sink-mute @DEFAULT_SINK@ toggle";
          XF86AudioNext = "exec ${playerctl} next";
          XF86AudioPrev = "exec ${playerctl} previous";
          XF86AudioPlay = "exec ${playerctl} play-pause";
          XF86AudioStop = "exec ${playerctl} stop";
          XF86MonBrightnessUp = "exec ${brightnessctl} set +5%";
          XF86MonBrightnessDown = "exec ${brightnessctl} set 5%-";
          "${mod}+Shift+s" = ''exec ${grim} -g "$(${slurp})" - | ${pngquant} - | ${wl-copy} '';
        };
    };
    extraConfig = ''
      # clamshell mode i.e. disable internal display when closed
      bindswitch --reload --locked lid:on output $laptop disable
      bindswitch --reload --locked lid:off output $laptop enable
    '';
  };

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = ../configs/waybar/style.css;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 25;
        width = 2560;
        spacing = 0;
        id = "waybar";
        ipc = true;
        modules-left = [ "sway/workspaces" "sway/mode" ];
        modules-center = [ "sway/window" ];
        modules-right = [ "custom/spt" "pulseaudio" "battery" "clock" "tray" ];
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
            pgrep = "${pkgs.coreutils}/bin/pgrep";
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
  xdg.configFile."waybar/base16-dracula.css".source = ../configs/waybar/base16-dracula.css;

  services.blueman-applet.enable = true;

  systemd.user.services.network-manager-applet = {
    Unit = {
      Description = "Network Manager applet";
      Requires = [ "tray.target" ];
      After = [ "graphical-session-pre.target" "tray.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Install = { WantedBy = [ "graphical-session.target" ]; };

    Service = {
      ExecStart = "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator";
    };
  };
}
