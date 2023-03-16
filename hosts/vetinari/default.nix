{ config, lib, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "vetinari";

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.home-assistant = {
    enable = true;

    extraComponents = [
      "default_config"
      "met"
      "esphome"
      "backup"
      "zha"
      "fritz"
      "mqtt"
    ];

    config = {
      default_config = { };
      http = {
        use_x_forwarded_for = true;
        trusted_proxies = [ "100.64.0.0/10" "fd7a:115c:a1e0::/48" ];
      };
    };
  };

  services.mosquitto = {
    enable = true;
    listeners = [
      {
        acl = [ "pattern readwrite #" ];
        omitPasswordAuth = true;
        settings.allow_anonymous = true;
      }
    ];
  };

  networking.firewall.allowedTCPPorts = [ 1883 ];

  system.stateVersion = lib.mkForce "23.05";
}
