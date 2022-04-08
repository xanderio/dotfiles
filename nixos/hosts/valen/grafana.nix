{ config, ... }:
{
  services = {
    grafana = {
      enable = true;
      domain = "grafana.xanderio.de";
    };

    nginx.virtualHosts.${config.services.grafana.domain} = {
      enableACME = true;
      forceSSL = true;
      proxyPass = "http://localhost:${toString config.services.grafana.port}";
      proxyWebsockets = true;
    };
  };
}
