{ ... }: {
  imports = [
    ../common
    ./boot.nix
    ./cachix.nix
    ./desktop.nix
    ./firewall.nix
    ./fonts.nix
    ./users.nix
    ./services.nix
    ./programs.nix
  ];

  hardware = {
    bluetooth.enable = true;
    enableRedistributableFirmware = true;
  };

  security.sudo.wheelNeedsPassword = false;

  networking = {
    useDHCP = false;
    wireless.enable = false;
    wireless.iwd.enable = true;
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
  };

  nix.settings.trusted-users = [ "root" "xanderio" ];
}
