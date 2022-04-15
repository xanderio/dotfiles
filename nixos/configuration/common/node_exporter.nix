{...}: {
  services.prometheus = {
    exporters = {
      node = {
        enable = true;
        enabledCollectors = ["systemd"];
        openFirewall = true;
        firewallFilter = "-i ens10 -p tcp -m tcp --dport 9100";
      };
    };
  };
}
