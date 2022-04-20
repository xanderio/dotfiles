{ pkgs
, config
, ...
}: {
  home.stateVersion = "22.05";
  xdg.configFile."nix/nix.conf".source = ./configs/nix/nix.conf;
  nixpkgs.config = import ./configs/nix/config.nix;
  imports = [
    ./modules/chromium.nix
    ./modules/darcs.nix
    ./modules/easyeffects.nix
    ./modules/firefox.nix
    ./modules/fish.nix
    ./modules/fonts.nix
    ./modules/foot.nix
    ./modules/games.nix
    ./modules/git.nix
    ./modules/gpg.nix
    ./modules/gtk.nix
    ./modules/home-manager.nix
    ./modules/misc.nix
    ./modules/neovim.nix
    ./modules/nix-utilities.nix
    ./modules/rust.nix
    ./modules/ssh.nix
    ./modules/starship.nix
    ./modules/taskwarrior.nix
    ./modules/wayland
  ];
}
