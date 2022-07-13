{pkgs, ...}: {
  home.sessionVariables = {
    BROWSER = "firefox";
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_DISABLE_RDD_SANDBOX = "1";
  };
  programs = {
    firefox = {
      enable = true;
      package = pkgs.firefox-wayland;
    };
  };
}
