{ pkgs, ... }:
let
  nerdfontSymbolsOnly2024em = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/ryanoasis/nerd-fonts/aabed73fdd141bb8ff887b17e2acbe8187f007b8/patched-fonts/NerdFontsSymbolsOnly/complete/Symbols-2048-em%20Nerd%20Font%20Complete.ttf";
    name = "Symbols-2048-em Nerd Font Complete.ttf";
    sha256 = "2qhN3+yFP7k4kI4F2jBD3l2fpKGCQ8vH8hnoHh8urFk=";
  };
  nerdfontSymbolsOnly = pkgs.runCommand "nerdfont-symbols" { prefer-local-build = true; } ''
    dst=$out/share/fonts/NerdFontsSymbols
    mkdir -p $dst
    
    ln -s "${nerdfontSymbolsOnly2024em}" "$dst/Symbols-2048-em Nerd Font Complete.ttf"
  '';
  nerdfontConfig = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/ryanoasis/nerd-fonts/aabed73fdd141bb8ff887b17e2acbe8187f007b8/10-nerd-font-symbols.conf";
    sha256 = "1qy39f3idfpxrs9q61x2s3m4kz7ghqn0vhw0c2cmw0x40wxfglx1";
  };
  nerdfontConfigPkg = pkgs.runCommand "nerdfont-conf"
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
      nerdfontSymbolsOnly
    ];
  };
}
