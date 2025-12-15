{ pkgs, ... }:
{
  config = {
    users.users.xanderio.extraGroups = [ "incus-admin" ];

    networking.useDHCP = false;
    networking.bridges.br0 = {
      interfaces = [ "eno1" ];
    };
    networking.interfaces.br0 = {
      useDHCP = true;
      macAddress = "ac:e2:d3:13:8c:37";
    };
    # systemd.network = {
    #   netdevs."40-br0" = {
    #     netdevConfig = {
    #       MACAddress = "ac:e2:d3:13:8c:37";
    #     };
    #   };
    # };
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
