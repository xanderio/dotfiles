{ pkgs
, config
, ...
}: {
  services.prometheus = {
    enable = true;
    enableReload = true;

    globalConfig.scrape_interval = "15s";
    scrapeConfigs = [
      {
        job_name = "prometheus";
        static_configs = [
          {
            targets = [ "localhost:${toString config.services.prometheus.port}" ];
          }
        ];
      }
      {
        job_name = "node";
        static_configs = [
          {
            targets =
              let
                makeTarget = name: "${name}.internal.hs.xanderio.de:${toString config.services.prometheus.exporters.node.port}";
              in
              builtins.map makeTarget [ "valen" "delenn" "block" ];
          }
        ];
        relabel_configs = [
          {
            source_labels = [ "__address__" ];
            target_label = "instance";
            regex = "(.*?)\\..*";
            replacement = "\${1}.xanderio.de";
          }
        ];
      }
    ];
  };
  services.borgbackup.jobs.backup.exclude = [ "/var/lib/prometheus2" ];
  networking.firewall.interfaces."tailscale0".allowedTCPPorts = [ 9090 ];
}
