{ pkgs, config, ... }:
let
  s3_port = 3900;
  s3web_port = 3902;
in
{
  config = {
    x.sops.secrets."services/garage/rpc_secret" = { };
    x.sops.secrets."services/garage/admin_token" = { };
    x.sops.secrets."services/garage/metrics_token" = { };
    sops.templates."sops.env" = {
      content = ''
        GARAGE_RPC_SECRET=${config.sops.placeholder."services/garage/rpc_secret"}
        GARAGE_ADMIN_TOKEN=${config.sops.placeholder."services/garage/admin_token"}
        GARAGE_METRICS_TOKEN=${config.sops.placeholder."services/garage/metrics_token"}
      '';
    };

    services.nginx = {
      enable = true;
      virtualHosts = {
        "s3.xanderio.de" = {
          enableACME = true;
          forceSSL = true;
          locations."/" = {
            proxyPass = "http://[::1]:${toString s3_port}";
            extraConfig = ''
              # Disable buffering to a temporary file.
              proxy_max_temp_file_size 0;
              client_max_body_size 0;
            '';
          };
        };
        "s3web.xanderio.de" = {
          enableACME = true;
          forceSSL = true;
          locations."/" = {
            proxyPass = "http://[::1]:${toString s3web_port}";
            extraConfig = ''
              # Disable buffering to a temporary file.
              proxy_max_temp_file_size 0;
            '';
          };
        };
      };
    };

    systemd.tmpfiles.settings."10-garage"."/run/garage".d.user = "garage";
    systemd.services.garage.serviceConfig = {
      User = "garage";
      Group = "garage";
      # disable as data_dir is outside of /var/lib/
      DynamicUser = false;
      ReadWritePaths = [ "/run/garage/" ];
    };

    users.users.garage = {
      isSystemUser = true;
      group = "garage";
    };
    users.groups.garage = {};

    services.garage = {
      enable = true;
      package = pkgs.garage_2;
      environmentFile = config.sops.templates."sops.env".path;
      settings = {
        replication_factor = 1;
        rpc_bind_addr = "[::]:3901";
        s3_api = {
          api_bind_addr = "[::1]:${toString s3_port}";
          s3_region = "garage";
          root_domain = ".s3.xanderio.de";
        };
        s3_web = {
          bind_addr = "[::1]:${toString s3web_port}";
          root_domain = ".s3web.xanderio.de";
        };
        admin = {
          api_bind_addr = "/run/garage/admin.sock";
        };
        data_dir = [
          {
            capacity = "4T";
            path = "/tank/garage";
          }
        ];
      };
    };
  };
}
