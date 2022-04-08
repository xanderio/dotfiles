{ pkgs, ... }:
{
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";

    # remove when https://github.com/NixOS/nixpkgs/issues/167785 is fixed
    MOZ_DISABLE_CONTENT_SANDBOX = "1";
  };
  programs = {
    firefox = {
      enable = true;
      package = pkgs.firefox-wayland;
    };
  };
}
