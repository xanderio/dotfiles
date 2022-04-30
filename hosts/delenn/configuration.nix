{name, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./miniflux.nix
    ./nextcloud.nix
    ./taskserver.nix
    ./paperless.nix
    ./hass.nix
  ];

  boot.loader.grub.device = "/dev/sda";

  networking = {
    useDHCP = false;
    interfaces.ens3.useDHCP = true;
    interfaces.ens10.useDHCP = true;
    interfaces.ens3.ipv6.addresses = [
      {
        address = "2a01:4f8:c0c:240e::1";
        prefixLength = 64;
      }
    ];
    defaultGateway6 = {
      address = "fe80::1";
      interface = "ens3";
    };
    nameservers = ["2a01:4ff:ff00::add:1" "2a01:4ff:ff00::add:2" "185.12.64.1" "185.12.64.2"];
  };

  services = {
    nginx.enable = true;

    borgbackup.jobs = {
      backup = {
        paths = ["/"];
        exclude = ["/nix" "'**/.cache'" "/proc" "/sys"];
        repo = "u289342@u289342.your-storagebox.de:backup/${name}";
        encryption = {
          mode = "repokey-blake2";
          passCommand = "cat /var/borg/passphrase";
        };
        environment = {BORG_RSH = "ssh -p 23 -i /var/borg/id_ed25519";};
        compression = "auto,zstd,10";
        startAt = "daily";
      };
    };
  };
}
