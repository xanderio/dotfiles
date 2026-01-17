{ config, ... }:
let
  webhookPort = 7292;
in
{
  config = {
    services.matrix-hookshot = {
      enable = true;
      registrationFile = config.sops.templates."synapse-appservice-hookshot.yaml".path;
      settings = {
        bridge = {
          bindAddress = "localhost";
          domain = "bitflip.jetzt";
          mediaUrl = "https://bitflip.jetzt";
          port = 9993;
          url = "http://localhost:8008";
        };
        logging.level = "debug";
        listeners = [
          {
            bindAddress = "localhost";
            port = webhookPort;
            resources = [
              "webhooks"
            ];
          }
        ];
        permissions = [
          {
            actor = "@xanderio:bitflip.jetzt";
            services = [
              {
                service = "*";
                level = "admin";
              }
            ];
          }
        ];
        generic = {
          enabled = true;
          outbound = true;
          urlPrefix = "https://bitflip.jetzt/hookshot/webhook/";
          userIdPrefix = "_webhooks_";
        };
      };
    };

    services.nginx.virtualHosts = {
      "bitflip.jetzt" = {
        locations."/hookshot/" = {
          proxyPass = "http://localhost:${toString webhookPort}/";
        };
      };
    };

    x.sops.secrets = {
      "services/synapse/hookshot/as_token" = { };
      "services/synapse/hookshot/hs_token" = { };
    };
    sops.templates."synapse-appservice-hookshot.yaml" = {
      owner = "matrix-synapse";
      restartUnits = [ "matrix-synapse.service" ];
      content = builtins.toJSON {
        id = "matrix-hookshot";
        url = "http://localhost:${toString config.services.matrix-hookshot.settings.bridge.port}";
        rate_limit = false;
        as_token = config.sops.placeholder."services/synapse/hookshot/as_token";
        hs_token = config.sops.placeholder."services/synapse/hookshot/hs_token";
        sender_localpart = "hookshot";
        namespaces = {
          users = [
            {
              exclusive = true;
              regex = "@_webhooks_.*:bitflip\\.jetzt";
            }
          ];
        };
      };
    };

    services.matrix-synapse.settings.app_service_config_files = [
      config.sops.templates."synapse-appservice-hookshot.yaml".path
    ];
  };
}
