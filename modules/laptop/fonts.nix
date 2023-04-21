{ pkgs, ... }:
let
  nerdfontConfig = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/ryanoasis/nerd-fonts/5c5c51e7b18eb080f1fa24df9d164a4b6ff62a6c/10-nerd-font-symbols.conf";
    sha256 = "0a9vazsv1yx01l4jrsvzmlfha76ak5rmcd7jiwls50wfd7h38iv3";
  };
  nerdfontConfigPkg =
    pkgs.runCommand "nerdfont-conf"
      {
        prefer-local-build = true;
      } ''
      dst=$out/etc/fonts/conf.d
      mkdir -p $dst

      ln -s ${nerdfontConfig} $dst/10-nerd-font-symbols.conf
    '';
in
{
  fonts = {
    fontconfig = {
      enable = true;
      confPackages = [ nerdfontConfigPkg ];
    };
    enableDefaultFonts = true;
    fonts = with pkgs; [
      corefonts
      freefont_ttf
      jetbrains-mono
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    ];
  };
}
