{ ... }:
{
  networking.firewall.interfaces."tailscale0".allowedTCPPorts = [ 3030 ];
  services.loki = {
    enable = true;
    configuration = {
      server.http_listen_port = 3030;
      auth_enabled = false;

      ingester = {
        lifecycler = {
          address = "127.0.0.1";
          ring = {
            kvstore = {
              store = "inmemory";
            };
            replication_factor = 1;
          };
        };
        chunk_idle_period = "1h";
        max_chunk_age = "1h";
        chunk_target_size = 999999;
        chunk_retain_period = "30s";
        max_transfer_retries = 0;
      };

      schema_config = {
        configs = [{
          from = "2022-06-06";
          store = "boltdb-shipper";
          object_store = "filesystem";
          schema = "v11";
          index = {
            prefix = "index_";
            period = "24h";
          };
        }
          {
            from = "2023-05-19";
            store = "tsdb";
            object_store = "filesystem";
            schema = "v12";
            index = {
              prefix = "index_";
              period = "24h";
            };
          }];
      };

      storage_config = {
        boltdb_shipper = {
          active_index_directory = "/var/lib/loki/boltdb-shipper-active";
          cache_location = "/var/lib/loki/boltdb-shipper-cache";
          cache_ttl = "24h";
          shared_store = "filesystem";
        };

        tsdb_shipper = {
          active_index_directory = "/var/lib/loki/tsdb-index";
          cache_location = "/var/lib/loki/tsdb-cache";
          cache_ttl = "24h";
          shared_store = "filesystem";
        };

        filesystem = {
          directory = "/var/lib/loki/chunks";
        };
      };

      limits_config = {
        reject_old_samples = true;
        reject_old_samples_max_age = "168h";
        retention_period = "2520h"; # 15 weeks
      };

      chunk_store_config = {
        max_look_back_period = "0s";
      };

      table_manager = {
        retention_deletes_enabled = true;
        retention_period = "2520h"; # 15 weeks
      };

      compactor = {
        retention_enabled = true;
        working_directory = "/var/lib/loki";
        shared_store = "filesystem";
        compactor_ring = {
          kvstore = {
            store = "inmemory";
          };
        };
      };
    };
  };
}
