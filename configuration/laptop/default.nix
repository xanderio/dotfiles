{...}: {
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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

  hardware = {
    bluetooth.enable = true;
    enableRedistributableFirmware = true;
  };

  security.sudo.wheelNeedsPassword = false;

  networking = {
    useDHCP = false;
    wireless.enable = false;
    networkmanager.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
  };

  nix.settings.trusted-users = ["root" "xanderio"];
}
