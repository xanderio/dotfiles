{
  config,
  ...
}:
{
  services.postgresql = {
    enable = true;
    ensureUsers = [
      {
        name = "matrix-authentication-service";
        ensureDBOwnership = true;
      }
    ];
    ensureDatabases = [ "matrix-authentication-service" ];
  };

  services.nginx = {
    enable = true;
    virtualHosts."mas.bitflip.jetzt" = {
      enableACME = true;
      forceSSL = true;
      locations = {
        "/" = {
          proxyPass = "http://[::]:8085";
          extraConfig = ''
            proxy_http_version 1.1;
          '';
        };
        "/assets/" = {
          alias = "${config.services.matrix-authentication-service.package}/share/matrix-authentication-service/assets/";
          extraConfig = ''
            expires 365d;
          '';
        };
      };
    };
  };

  x.sops.secrets = {
    "services/mas-synapse/client_secret" = { };
    "services/mas-synapse/homeserver_secret" = { };
    "services/mas-synapse/encryption" = { };
    "services/mas-synapse/signing_key_rsa" = { };
    "services/mas-synapse/signing_key_ec" = { };
    "services/mas-synapse/upstream_client_secret" = { };
  };

  sops.templates."mas-secrets" = {
    content = builtins.toJSON {
      clients = [
        {
          client_id = "0000000000000000000SYNAPSE";
          client_auth_method = "client_secret_basic";
          client_secret = config.sops.placeholder."services/mas-synapse/client_secret";
        }
      ];
      matrix = {
        homeserver = "bitflip.jetzt";
        secret = config.sops.placeholder."services/mas-synapse/homeserver_secret";
        endpoint = "http://[::1]:8008";
      };
      secrets = {
        encryption = config.sops.placeholder."services/mas-synapse/encryption";
        keys = [
          {
            kid = "12o9asd9";
            key_file = "/run/credentials/matrix-authentication-service.service/signing_key_rsa";
          }
          {
            kid = "6d2ddc8a";
            key_file = "/run/credentials/matrix-authentication-service.service/signing_key_ec";
          }
        ];
      };
      upstream_oauth2.providers = [
        {
          id = "01JFF55FPW4AG33K6YHS860CRB";
          client_id = "synapse";
          client_secret = config.sops.placeholder."services/mas-synapse/upstream_client_secret";
          issuer = "https://sso.xanderio.de/application/o/synapse/";
          scope = "openid profile email";
          token_endpoint_auth_method = "client_secret_post";
          claims_imports = {
            subject.template = "{{ user.sub }}";
            localpart = {
              action = "suggest";
              template = "{{ user.preferred_username }}";
            };
            displayname = {
              action = "suggest";
              template = "{{ user.name }}";
            };
            email = {
              action = "force";
              template = "{{ user.email }}";
              set_email_verification = "import";
            };
          };
        }
      ];
    };
  };

  systemd.services.matrix-authentication-service.serviceConfig.LoadCredential = [
    "mas-secrets.yaml:${config.sops.templates."mas-secrets".path}"
    "signing_key_ec:${config.sops.secrets."services/mas-synapse/signing_key_ec".path}"
    "signing_key_rsa:${config.sops.secrets."services/mas-synapse/signing_key_rsa".path}"
  ];

  services.matrix-authentication-service = {
    enable = true;
    extraConfigFiles = [ "/run/credentials/matrix-authentication-service.service/mas-secrets.yaml" ];
    settings = {
      http = {
        public_base = "https://mas.bitflip.jetzt";
        listeners = [
          {
            name = "web";
            resources = [
              {
                name = "discovery";
              }
              {
                name = "human";
              }
              {
                name = "oauth";
              }
              {
                name = "compat";
              }
              {
                name = "graphql";
                playground = true;
              }
            ];
            binds = [
              { address = "[::]:8085"; }
            ];
          }
        ];
      };
      database = {
        uri = "postgres:///matrix-authentication-service";
      };
      passwords.enabled = false;
    };
  };
}
