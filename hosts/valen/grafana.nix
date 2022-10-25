{ config, ... }: {
  services = {
    grafana = {
      enable = true;
      settings.server = {
        domain = "grafana.xanderio.de";
        rootUrl = "https://grafana.xanderio.de";
      };
    };

    prometheus.scrapeConfigs = [
      {
        job_name = "grafana";
        static_configs = [
          {
            targets = [ "localhost:${toString config.services.grafana.settings.server.http_port}" ];
          }
        ];
      }
    ];

    nginx = {
      enable = true;
      virtualHosts.${config.services.grafana.settings.server.domain} = {
        enableACME = true;
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://localhost:${toString config.services.grafana.settings.server.http_port}";
          proxyWebsockets = true;
        };
      };
    };
  };
}
