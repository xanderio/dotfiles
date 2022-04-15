{pkgs, ...}: {
  programs = {
    chromium = {
      enable = true;
    };
  };
  nixpkgs.config.chromium.commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
}
