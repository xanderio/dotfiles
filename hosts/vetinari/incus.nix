{ pkgs, ... }:
{
  config = {
    users.users.xanderio.extraGroups = [ "incus-admin" ];

    networking.useDHCP = false;
    systemd.network = {
      netdevs."20-br0" = {
        netdevConfig = {
          Name = "br0";
          Kind = "bridge";
          MACAddress = "ac:e2:d3:13:8c:37";
        };
      };
      links."20-br0" = {
        matchConfig.OriginalName = "br0";
      };

      networks = {
        "20-eno1" = {
          name = "eno1";
          networkConfig.Bridge = "br0";
        };
        "20-br0" = {
          name = "br0";
          networkConfig = {
            DHCP = "yes";
            MulticastDNS = "yes";
            DNSOverTLS = "opportunistic";
            IPv6AcceptRA = "yes";
            IPv6PrivacyExtensions = "yes";
          };
        };
      };
    };
    networking.firewall.trustedInterfaces = [ "incusbr*" ];

    systemd.services."incus-dns-incusbr0" = {
      description = "Incus per-link DNS configuration for incusbr0";
      wantedBy = [ "sys-subsystem-net-devices-incusbr0.device" ];
      bindsTo = [ "sys-subsystem-net-devices-incusbr0.device" ];
      after = [ "sys-subsystem-net-devices-incusbr0.device" ];

      serviceConfig = {
        Type = "oneshot";
        ExecStart = [
          "resolvectl dns incusbr0 10.176.11.1"
          "resolvectl domain incusbr0 incus.home.xanderio.de"
        ];
        ExecStopPost = [
          "resolvectl revert incusbr0"
        ];
        RemainAfterExit = true;
      };
    };

    virtualisation.incus = {
      enable = true;
      package = pkgs.incus;
      ui.enable = true;
    };
  };
}
