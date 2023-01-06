{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    neovim
    iwd
  ];
  programs.mtr.enable = true;
  programs.adb.enable = false;
  programs.fuse.userAllowOther = true;
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "xanderio" ];
  };
}
