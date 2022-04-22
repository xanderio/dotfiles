{ pkgs, ... }: {
  imports = [
    ./kanshi.nix
    ./mako.nix
    ./sway
    ./swayidle.nix
    ./tray-items.nix
    ./waybar
  ];
  xsession.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
  };
}
