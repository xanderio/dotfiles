{pkgs, ...}: {
  imports = [
    ./kanshi.nix
    ./mako.nix
    ./sway
    ./swayidle.nix
    ./swaylock
    ./tray-items.nix
    ./waybar
  ];
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
  };
}
