{ config, lib, pkgs, ... }:
let
  domain = "mail.xanderio.de";
  credPath = "/run/credentials/stalwart-mail.service";
in
{
  config = {
    x.sops.secrets."services/stalwart/adminPwd" = { };

    security.acme.certs."${domain}" = {
      extraDomainNames = [ "autoconfig.bitflip.jetzt" "autodiscovery.bitflip.jetzt" "autoconfig.xanderio.de" "autodiscovery.xanderio.de" ];
    };

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

    services.nginx.virtualHosts = {
      "autoconfig.*" = {
        serverAliases = [ "autodiscovery.*" ];
        forceSSL = true;
        useACMEHost = "${domain}";
        locations."/" = {
          proxyPass = "http://[::1]:8119";
          proxyWebsockets = true;
        };
      };
      "${domain}" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://[::1]:8119";
          proxyWebsockets = true;
        };
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

        lookup.default.hostname = "mail.xanderio.de";
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
            jmap = {
              bind = [ "[::]:993" ];
              protocol = "imap";
              tls.implicit = true;
            };
            imaptls = {
              bind = [ "[::]:993" ];
              protocol = "imap";
              tls.implicit = true;
            };
            management = {
              bind = [ "[::1]:8119" ];
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
