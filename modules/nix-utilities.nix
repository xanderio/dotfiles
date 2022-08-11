{ pkgs, ... }: {
  home.packages = with pkgs; [
    any-nix-shell
    comma
  ];
  programs.nix-index.enable = true;
}
