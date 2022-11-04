{ pkgs, ... }: {
  imports = [
    ./wayland
  ];
  home = {
    sessionVariables = {
      BROWSER = "firefox";
      MOZ_ENABLE_WAYLAND = "1";
      MOZ_DISABLE_RDD_SANDBOX = "1";
      NIXOS_OZONE_WL = "1";
    };
    packages = with pkgs; [
      thunderbird
      imv
      mpv
      pdfarranger
      freecad
      mumble
      digikam
      darktable
      xdg-utils
      ntfy-sh
      bibata-cursors
      ripdrag
      prismlauncher
      element-desktop
    ];
  };

  fonts.fontconfig.enable = true;

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };

  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
    };
    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };
    theme = {
      package = pkgs.gnome-themes-extra;
      name = "Adwaita-dark";
    };
    gtk2.extraConfig = "gtk-application-prefer-dark-theme = true";
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  programs = {
    chromium = {
      enable = true;
      commandLineArgs = [ "--enable-features=UseOzonePlatform" "--ozone-platform=wayland" ];
    };
    firefox = {
      enable = true;
      package = pkgs.firefox-wayland;
    };
    foot = {
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
  };

  xdg.configFile."ntfy/client.yml".text = ''
    default-host: https://ntfy.xanderio.de
  '';

  nixpkgs.config = {
    allowUnfree = true;
    keep-derivations = true;
    keep-outputs = true;
  };
  xdg.configFile."nix/nix.conf".text = ''
    experimental-features = nix-command flakes
  '';
}
