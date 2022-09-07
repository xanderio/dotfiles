{ ... }: {
  networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 9100 ];
  services.prometheus = {
    exporters = {
      node = {
        enable = true;
        enabledCollectors = [ "systemd" ];
      };
    };
  };
}
