{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    neovim
    iwd
  ];
  programs.mtr.enable = true;
  programs.adb.enable = false;
  programs.fuse.userAllowOther = true;
}
