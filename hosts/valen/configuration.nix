{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./grafana.nix
    ./prometheus.nix
  ];

  boot = {
    loader.grub.device = "/dev/sda";
  };

  networking = {
    useDHCP = false;
    interfaces.ens3.useDHCP = true;
    interfaces.ens3.ipv6.addresses = [
      {
        address = "2a01:4f8:c0c:368c::1";
        prefixLength = 64;
      }
    ];
    defaultGateway6 = {
      address = "fe80::1";
      interface = "ens3";
    };
    nameservers = [
      "2a01:4ff:ff00::add:1"
      "2a01:4ff:ff00::add:2"
      "185.12.64.1"
      "185.12.64.2"
    ];
  };
}
