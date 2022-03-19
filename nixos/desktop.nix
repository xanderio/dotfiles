{ pkgs, ... }:
{
  programs.sway.enable = true;
  programs.fish.enable = true;
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    swaylock
    gnome-icon-theme
    gnome3.adwaita-icon-theme
    gnomeExtensions.appindicator
  ];

  services.udev.packages = with pkgs; [ gnome3.gnome-settings-daemon ];

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