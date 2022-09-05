{ ... }: {
  imports = [
    ../common
    ./boot.nix
    ./desktop.nix
    ./fonts.nix
    ./users.nix
    ./services.nix
    ./programs.nix
  ];

  hardware = {
    bluetooth = {
      enable = true;
      settings = {
        General = {
          JustWorksRepairing = "always";
          FastConnectable = true;
          Class = "0x000100";
        };
        Policy = {
          AutoEnable = true;
        };
      };
    };
    enableRedistributableFirmware = true;
  };

  security.sudo.wheelNeedsPassword = false;

  networking = {
    useDHCP = false;
    useNetworkd = true;
    usePredictableInterfaceNames = false;
    wireless.enable = false;
    wireless.iwd = {
      enable = true;
      settings.Settings.AutoConnect = true;
    };
  };

  systemd.network.networks =
    let
      networkConfig = {
        DHCP = "yes";
        MulticastDNS = "yes";
        DNSOverTLS = "opportunistic";
        IPv6AcceptRA = "yes";
        IPv6PrivacyExtensions = "yes";
        LinkLocalAddressing = "yes";
      };
    in
    {
      "30-wireless" = {
        enable = true;
        name = "wl*";
        inherit networkConfig;
        dhcpV4Config.RouteMetric = 100;
        ipv6AcceptRAConfig.RouteMetric = 100;
        extraConfig = ''
          [Network]
          IgnoreCarrierLoss=3s
        '';
      };
      "40-wired" = {
        enable = true;
        name = "en*";
        inherit networkConfig;
        linkConfig.RequiredForOnline = "no";
        dhcpV4Config.RouteMetric = 200; # prefer wired
        ipv6AcceptRAConfig.RouteMetric = 200;
      };
    };
  systemd.network.wait-online.anyInterface = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  nix.settings.trusted-users = [ "root" "xanderio" ];
}
