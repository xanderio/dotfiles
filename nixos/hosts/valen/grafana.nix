{ config, ... }:
{
  services = {
    grafana = {
      enable = true;
      domain = "grafana.xanderio.de";
    };

    prometheus.scrapeConfigs = [
      {
        job_name = "grafana";
        static_configs = [{
          targets = [ "localhost:${toString config.services.grafana.port}" ];
        }];
      }
    ];

    nginx = {
      enable = true;
      virtualHosts.${config.services.grafana.domain} = {
        enableACME = true;
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://localhost:${toString config.services.grafana.port}";
          proxyWebsockets = true;
        };
      };
    };
  };
}
