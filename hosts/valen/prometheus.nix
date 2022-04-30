{
  pkgs,
  config,
  ...
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
            targets = ["localhost:${toString config.services.prometheus.port}"];
          }
        ];
      }
      {
        job_name = "wireguard";
        static_configs = [
          {
            targets = ["10.0.1.2:${toString config.services.prometheus.exporters.wireguard.port}"];
          }
        ];
      }
      {
        job_name = "node";
        hetzner_sd_configs = [
          {
            authorization.credentials_file = "/var/hcloud_token";
            role = "hcloud";
          }
        ];
        relabel_configs = [
          {
            source_labels = ["__meta_hetzner_server_name"];
            target_label = "instance";
            replacement = "$1";
          }
          {
            source_labels = ["__meta_hetzner_hcloud_private_ipv4_intern"];
            target_label = "__address__";
            replacement = "$1:9100";
          }
        ];
      }
    ];
  };
}
