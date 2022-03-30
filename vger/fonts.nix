{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;
  fonts.enableDefaultFonts = true;
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    freefont_ttf
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    jetbrains-mono
  ];
}
