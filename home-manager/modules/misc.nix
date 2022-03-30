{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    ripgrep
    ansible
    bacon
    fd
    terraform
    taplo-cli
    htop

    thunderbird
    mumble

    cura
    freecad

    yarn
    rustup
    sccache

    android-studio
  ];

  programs.direnv.enable = true;
  programs.exa.enable = true;
  programs.jq.enable = true;
  programs.bat = {
    enable = true;
    config = {
      theme = "Dracula";
    };
  };
}
