{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  fuzzelOptions = lib.strings.concatStringsSep " " [
    ''--font="JetBrains Mono"''
    "--background-color=282a36ee"
    "--text-color=f8f8f2ff"
    "--selection-color=44475aee"
    "--selection-text-color=ff79c6ff"
    "--border-width=0"
  ];
  fuzzel = pkgs.writers.writeBash "fuzzel" ''
    ${pkgs.fuzzel}/bin/fuzzel ${fuzzelOptions}
  '';
  background = ./background.png;
in {
  options.xanderio.sway.scale = mkOption {
    default = "1";
    type = types.str;
  };
  config = {
    home = {
      packages = with pkgs; [
        wl-clipboard

        font-awesome
      ];
      sessionVariables = {
        WLR_DRM_NO_MODIFIERS = "1";
        _JAVA_AWT_WM_NONREPARENTING = "1";
      };
    };

    wayland.windowManager.sway = {
      enable = true;
      # use system provided sway version, nixpkgs version is unable to create egl context
      package = null;
      systemdIntegration = true;
      wrapperFeatures.gtk = true;
      config = {
        modifier = "Mod4";
        terminal = "${pkgs.foot}/bin/foot";
        menu = toString fuzzel;
        bars = [];
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
            scale = config.xanderio.sway.scale;
            pos = "0 0";
          };
          "*".bg = "${background} fill";
        };
        colors = let
          red = "#FF5555";
          blue = "#6272A4";
          white = "#F8F8F2";
          grey = "#BFBFBF";
          darker_grey = "#282A36";
          dark_grey = "#44475A";
        in {
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
        keybindings = let
          cfg = config.wayland.windowManager.sway.config;
          mod = cfg.modifier;

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
            "${mod}+Backspace" = "exec swaylock";

            "${mod}+Control+Shift+${cfg.left}" = "move workspace to output left";
            "${mod}+Control+Shift+${cfg.right}" = "move workspace to output right";
            "${mod}+Control+Shift+${cfg.up}" = "move workspace to output up";
            "${mod}+Control+Shift+${cfg.down}" = "move workspace to output down";

            "${mod}+Control+Shift+Left" = "move workspace to output left";
            "${mod}+Control+Shift+Right" = "move workspace to output right";
            "${mod}+Control+Shift+Up" = "move workspace to output up";
            "${mod}+Control+Shift+Down" = "move workspace to output down";

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
        bindswitch --reload --locked lid:on output eDP-1 disable
        bindswitch --reload --locked lid:off output eDP-1 enable

        # Inhibit Idle if a window is fullscreen
        for_window [class="^.*"] inhibit_idle fullscreen
        for_window [app_id="^.*"] inhibit_idle fullscreen

        # Display window as floating. Find out wayland app_id with "swaymsg -t get_tree | jq '.' | grep app_id" and xorg class with xprop
        for_window [window_role = "pop-up"] floating enable
        for_window [window_role = "bubble"] floating enable
        for_window [window_role = "dialog"] floating enable
        for_window [window_type = "dialog"] floating enable
        for_window [window_role = "task_dialog"] floating enable
        for_window [window_type = "menu"] floating enable
        for_window [app_id = "floating"] floating enable
        for_window [app_id = "floating_update"] floating enable, resize set width 1000px height 600px
        for_window [class = "(?i)pinentry"] floating enable
        for_window [app_id = "Yad"] floating enable
        for_window [app_id = "yad"] floating enable
        for_window [title = ".*kdbx - KeePass"] floating enable, resize set 1276px 814px
        for_window [class = "KeePass2"] floating enable
        for_window [app_id = "nm-connection-editor"] floating enable
        for_window [class = "KeyStore Explorer"] floating enable
        for_window [app_id = "virt-manager"] floating enable
        for_window [app_id = "xfce-polkit"] floating enable
        for_window [instance = "origin.exe"] floating enable
        for_window [window_role = "About"] floating enable
        # Kill Firefox sharing indicator. It opens as an own container. Does not kill functionality
        for_window [title = "Firefox - Sharing Indicator"] kill
        for_window [title = "Firefox — Sharing Indicator"] kill
        for_window [app_id="firefox" title="Library"] floating enable, border pixel 1, sticky enable
        for_window [app_id = "pavucontrol"] floating enable
        for_window [app_id = "blueberry.py"] floating enable
        #for_window [title = "Thunderbird Preferences"] floating enable
        #for_window [name = "*Reminder"] floating enable
        for_window [title = "Manage KeeAgent.*"] floating enable
        for_window [title = "Page Info - .*"] floating enable
        for_window [class = "ConkyKeyboard"] floating enable
        for_window [class = "Gufw.py"] floating enable
        for_window [app_id = "keepassxc"] floating enable, resize set 1276px 814px
        for_window [app_id = "blueman-manager"] floating enable
        for_window [title = "^Open File$"] floating enable
        for_window [class = "^zoom$"] floating enable
        for_window [app_id = "avizo-service"] border pixel 0, sticky toggle
        no_focus [app_id="avizo-service"]
        for_window [window_role = "GtkFileChooserDialog"] resize set 590 340
        for_window [window_role = "GtkFiileChooserDialog"] move position center
        for_window [app_id = "tlp-ui"] floating enable
        for_window [title = "mpvfloat"] floating enable
        for_window [title = ".*Kee - Mozilla Firefox"] floating enable
        for_window [app_id = "nm-openconnect-auth-dialog"] floating enable
        for_window [class = "davmail-DavGateway"] floating enable
        for_window [title = "Open Database File"] floating enable
        for_window [app_id = "evolution-alarm-notify"] floating enable
        for_window [app_id = "gnome-calculator"] floating enable
        for_window [app_id="(?i)Thunderbird" title=".*Reminder"] floating enable
        for_window [class = "ATLauncher"] floating enable
        for_window [instance="lxappearance"] floating enable
        for_window [title="File Operation Progress"] floating enable, border pixel 1, sticky enable, resize set width 40 ppt height 30 ppt
        for_window [title="nmtui"] floating enable
        for_window [title="Save File"] floating enable
        for_window [app_id="wdisplays"] floating enable
        for_window [app_id="floating_shell_portrait"] floating enable, border pixel 1, sticky enable, resize set width 30 ppt height 40 ppt
        for_window [app_id="floating_shell"] floating enable, border pixel 1, sticky enable
        for_window [app_id = "qt5ct"] floating enable
        for_window [app_id = "gnome-tweaks"] floating enable
        for_window [class = "Bluetooth-sendto" instance = "bluetooth-sendto"] floating enable
        for_window [window_role = "Preferences"] floating enable
        for_window [title = "Picture in picture"] floating enable, sticky enable

        # Tag xwayland windows with [X]
        for_window [shell="xwayland"] title_format "<span>[X] %title </span>"
      '';
    };
  };
}
