{ config, lib, pkgs, ... }:
let
  domain = "mail.xanderio.de";
  credPath = "/run/credentials/stalwart-mail.service";
  configFormat = pkgs.formats.toml { };
  configFile = configFormat.generate "stalwart-mail.toml" config.services.stalwart-mail.settings;
in
{
  config = {
    x.sops.secrets."services/stalwart/adminPwd" = { };

    security.acme.certs."${domain}" = { };

    systemd.services.stalwart-mail = {
      wants = [ "acme-${domain}.service" ];
      after = [ "acme-${domain}.service" ];
      preStart = lib.mkForce ''
      '';
      serviceConfig = {
        LoadCredential = [
          "cert.pem:${config.security.acme.certs.${domain}.directory}/cert.pem"
          "key.pem:${config.security.acme.certs.${domain}.directory}/key.pem"
          "adminPwd:${config.sops.secrets."services/stalwart/adminPwd".path}"
        ];
      };
    };

    networking.firewall.allowedTCPPorts = [
      25 # smtp
      465 # smtp tls
      993 # imap tls
      4190 # manage sieve
    ];

    services.nginx.virtualHosts."${domain}" = {
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8119";
        proxyWebsockets = true;
      };
    };


    services.stalwart-mail = {
      enable = true;
      package = pkgs.stalwart-mail;
      settings = {
        certificate.default = {
          cert = "%{file:${credPath}/cert.pem}%";
          private-key = "%{file:${credPath}/key.pem}%";
          default = true;
        };

        lookup.default.hostname = config.networking.fqdn;
        server = {
          listener = {
            smtp = {
              bind = [ "[::]:25" ];
              protocol = "smtp";
            };
            submissions = {
              bind = [ "[::]:465" ];
              protocol = "smtp";
              tls.implicit = true;
            };
            imaptls = {
              bind = [ "[::]:993" ];
              protocol = "imap";
              tls.implicit = true;
            };
            management = {
              bind = [ "127.0.0.1:8119" ];
              protocol = "http";
            };
          };
        };

        store = {
          db = {
            type = "rocksdb";
            path = "%{env:STATE_DIRECTORY}%/db";
            compression = "lz4";
          };
        };

        storage = {
          directory = "internal";
          data = "db";
          blob = "db";
          fts = "db";
          lookup = "db";
        };

        authentication.fallback-admin = {
          user = "admin";
          secret = "%{file:${credPath}/adminPwd}%";
        };
      };
    };
  };
}
