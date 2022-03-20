{ ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.cleanTmpDir = true;
  zramSwap.enable = true;
  networking.hostName = "delenn";

  networking.useDHCP = false;
  networking.interfaces.ens3.useDHCP = true;
  networking.interfaces.ens3.ipv6.addresses = [{ address = "2a01:4f8:c0c:240e::1"; prefixLength = 64; }];
  networking.defaultGateway6 = { address = "fe80::1"; interface = "ens3"; };
  networking.nameservers = [ "2a01:4ff:ff00::add:1" "2a01:4ff:ff00::add:2" "185.12.64.1" "185.12.64.2" ];
}
