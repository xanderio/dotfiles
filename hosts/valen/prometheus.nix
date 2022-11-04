{ pkgs
, config
, ...
}:
let
  synapseRules = pkgs.writeText "" ''
    groups:
    - name: synapse
      rules:

      - record: synapse_storage_events_persisted_by_source_type
        expr: sum without(type, origin_type, origin_entity) (synapse_storage_events_persisted_events_sep_total{origin_type="remote"})
        labels:
          type: remote
      - record: synapse_storage_events_persisted_by_source_type
        expr: sum without(type, origin_type, origin_entity) (synapse_storage_events_persisted_events_sep_total{origin_entity="*client*",origin_type="local"})
        labels:
          type: local
      - record: synapse_storage_events_persisted_by_source_type
        expr: sum without(type, origin_type, origin_entity) (synapse_storage_events_persisted_events_sep_total{origin_entity!="*client*",origin_type="local"})
        labels:
          type: bridges

      - record: synapse_storage_events_persisted_by_event_type
        expr: sum without(origin_entity, origin_type) (synapse_storage_events_persisted_events_sep_total)

      - record: synapse_storage_events_persisted_by_origin
        expr: sum without(type) (synapse_storage_events_persisted_events_sep_total)
  '';
in
{
  services.prometheus = {
    enable = true;
    enableReload = true;

    ruleFiles = [ synapseRules ];
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
        job_name = "synapse";
        metrics_path = "/_synapse/metrics";
        static_configs = [
          {
            targets = [ "delenn.internal.hs.xanderio.de:8088" ];
          }
        ];
        relabel_configs = [
          {
            source_labels = [ "__address__" ];
            target_label = "instance";
            regex = ".*";
            replacement = "delenn.xanderio.de";
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
