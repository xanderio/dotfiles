{ pkgs, ... }:
{
  programs = {
    sway.enable = true;
    fish = {
      enable = true;
      shellAliases = { };
    };
    dconf.enable = true;
    file-roller.enable = true;
    gnome-disks.enable = true;
  };

  environment.systemPackages = with pkgs; [
    swaylock
    gnome-icon-theme
    hicolor-icon-theme # default fallback for icons
    gnome.adwaita-icon-theme
    gnome.gnome-themes-extra

    gnomeExtensions.appindicator
    networkmanagerapplet # needed for icons to work
    iwgtk # icons
    gammastep

    gnome.gnome-system-monitor
    gnome.nautilus
  ];

  gtk.iconCache.enable = true;

  programs.gnupg.agent.pinentryPackage = pkgs.pinentry-gnome;
  services = {
    udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
    gvfs.enable = true;
    gnome = {
      gnome-keyring.enable = true;
      sushi.enable = true;
    };

    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      extraConfig.pipewire = {
        "context.modules" = [
          {
            name = "libpipewire-module-zeroconf-discover";
            args = { };
          }
        ];
      };
    };
  };

  xdg.portal = {
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    wlr = {
      enable = true;
      settings = {
        screencast = {
          exec_before = "${pkgs.mako}/bin/makoctl set-mode do-not-disturb";
          exec_after = "${pkgs.mako}/bin/makoctl set-mode default";
          chooser_type = "simple";
          chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
        };
      };
    };
  };

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  # xdg-desktop-portal-wlr needs sh for exec_* to work
  systemd.user.services.xdg-desktop-portal-wlr.path = [ pkgs.bash ];
}
