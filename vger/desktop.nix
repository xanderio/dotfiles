{ pkgs, ... }:
{
  programs.sway.enable = true;
  programs.fish.enable = true;
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    swaylock
    gnome-icon-theme
    gnome3.adwaita-icon-theme
    gnome.gnome-themes-extra

    gnomeExtensions.appindicator

    gnome.gnome-system-monitor
    gnome.nautilus
    gnome.file-roller
    gnome.sushi
    gnome.seahorse
  ];

  services.udev.packages = with pkgs; [ gnome3.gnome-settings-daemon ];
  services.gvfs.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  xdg.portal.wlr = {
    enable = true;
    settings = {
      screencast = {
        exec_before = "${pkgs.mako}/bin/makoctl set-mode do-not-disturb";
        exec_after = "${pkgs.mako}/bin/makoctl set-mode default";
        chooser_type = "simple";
        chooser_cmd = "''${pkgs.slurp}/bin/slurp -f %o -or";
      };
    };
  };
}
