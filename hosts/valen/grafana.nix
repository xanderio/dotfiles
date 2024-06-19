{ config, ... }:
{
  x.sops.secrets."services/grafana/client_secret" = {
    owner = "grafana";
  };

  services = {
    grafana = {
      enable = true;
      settings = {
        server = {
          domain = "grafana.xanderio.de";
          root_url = "https://grafana.xanderio.de";
        };

        auth = {
          signout_redirect_url = "https://sso.xanderio.de/application/o/grafana/end-session/";
          oauth_auto_login = false;
        };

        "auth.generic_oauth" = {
          name = "SSO";
          icon = "signin";
          enabled = true;
          client_id = "grafana";
          client_secret = "$__file{${config.sops.secrets."services/grafana/client_secret".path}}";
          scopes = "openid profile email";
          auth_url = "https://sso.xanderio.de/application/o/authorize/";
          token_url = "https://sso.xanderio.de/application/o/token/";
          api_url = "https://sso.xanderio.de/application/o/userinfo/";

          role_attribute_path = "contains(to_array(info.groups)[*], 'grafana-admin') && 'GrafanaAdmin' || contains(to_array(info.groups)[*], 'grafana-editor') && 'Editor' || 'Viewer'";
          email_attribute_name = "email";

          allow_assign_grafana_admin = true;
        };
      };
    };

    prometheus.scrapeConfigs = [
      {
        job_name = "grafana";
        static_configs = [
          { targets = [ "localhost:${toString config.services.grafana.settings.server.http_port}" ]; }
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
