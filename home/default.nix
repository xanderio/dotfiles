{ pkgs
, config
, ...
}: {
  home.stateVersion = "22.05";
  home.packages = with pkgs; [
    bibata-cursors
  ];
  imports = [
    ./chromium.nix
    ./darcs.nix
    ./easyeffects.nix
    ./firefox.nix
    ./fish.nix
    ./fonts.nix
    ./foot.nix
    ./games.nix
    ./git.nix
    ./gpg.nix
    ./gtk.nix
    ./home-manager.nix
    ./misc.nix
    ./neovim
    ./nix
    ./nix-utilities.nix
    ./rust.nix
    ./ssh.nix
    ./starship.nix
    ./wayland
  ];
}
