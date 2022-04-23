{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    neovim
  ];
  programs.mtr.enable = true;
  programs.adb.enable = true;
}
