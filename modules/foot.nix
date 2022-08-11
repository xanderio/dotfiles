{ config
, pkgs
, ...
}: {
  home.packages = with pkgs; [
    xdg-utils
  ];
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "JetBrains Mono:size=10:weight=bold,TwitterColorEmoji";
        dpi-aware = "off";
      };
      bell.urgent = "yes";
      scrollback.lines = "100000";
      cursor.color = "82a36 f8f8f2";
      tweak.grapheme-shaping = "yes";
      colors = {
        alpha = "0.80";
        foreground = "f8f8f2";
        background = "282a36";
        regular0 = "000000";
        regular1 = "ff5555";
        regular2 = "50fa7b";
        regular3 = "f1fa8c";
        regular4 = "bd93f9";
        regular5 = "ff79c6";
        regular6 = "8be9fd";
        regular7 = "bfbfbf";
        bright0 = "4d4d4d";
        bright1 = "ff6e67";
        bright2 = "5af78e";
        bright3 = "f4f99d";
        bright4 = "caa9fa";
        bright5 = "ff92d0";
        bright6 = "9aedfe";
        bright7 = "e6e6e6";
      };
    };
  };
}
