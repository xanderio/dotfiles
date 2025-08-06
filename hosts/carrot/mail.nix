{
  config,
  lib,
  pkgs,
  ...
}:
let
  domain = "mail.xanderio.de";
  credPath = "/run/credentials/stalwart-mail.service";
  domains = [
    "xanderio.de"
    "bitflip.jetzt"
    "sieg.contact"
  ];
in
{
  config = {
    x.sops.secrets."services/stalwart/adminPwd" = { };

    security.acme.certs =
      {
        "${domain}" = { };
      }
      // lib.listToAttrs (
        map (d: {
          name = "mta-sts.${d}";
          value = {
            extraDomainNames = [
              "autoconfig.${d}"
              "autodiscovery.${d}"
            ];
          };
        }) domains
      );

    systemd.services.stalwart-mail = {
      wants = [ "acme-${domain}.service" ];
      after = [ "acme-${domain}.service" ];
      preStart = lib.mkForce '''';
      serviceConfig = {
        LogsDirectory = "stalwart-mail";
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

    services.nginx = {
      enable = true;
      virtualHosts =
        {
          "${domain}" = {
            forceSSL = true;
            enableACME = true;
            locations."/" = {
              proxyPass = "http://[::1]:8119";
              proxyWebsockets = true;
            };
          };
        }
        // lib.listToAttrs (
          map (d: {
            name = "mta-sts.${d}";
            value = {
              serverAliases = [
                "autoconfig.${d}"
                "autodiscovery.${d}"
              ];
              forceSSL = true;
              enableACME = true;
              locations = {
                "= /mail/config-v1.1.xml".proxyPass = "http://[::1]:8119";
                "= /autodiscovery/autodiscovery.xml".proxyPass = "http://[::1]:8119";
                "= /.well-known/mta-sts.txt".proxyPass = "http://[::1]:8119";
              };
            };
          }) domains
        );
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
              bind = [ "[::]:25" "0.0.0.0:25" ];
              protocol = "smtp";
            };
            submissions = {
              bind = [ "[::]:465" "0.0.0.0:465" ];
              protocol = "smtp";
              tls.implicit = true;
            };
            imaptls = {
              bind = [ "[::]:993" "0.0.0.0:993"];
              protocol = "imap";
              tls.implicit = true;
            };
            sieve = {
              bind = [ "[::]:4190" "0.0.0.0:4190"];
              protocol = "managesieve";
              tls.implicit = true;
            };
            management = {
              bind = [ "[::1]:8119" ];
              protocol = "http";
            };
          };
          http = {
            use-x-forwarded = true;
          };
        };

        tracer = {
          log = {
            enable = true;
            type = "log";
            path = "%{env:LOGS_DIRECTORY}%";
            prefix = "stalwart-mail.log";
            level = "info";
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

    services.roundcube = {
      enable = true;
      package = pkgs.roundcube.withPlugins (plugins: [ plugins.persistent_login ]);
      dicts = with pkgs.aspellDicts; [
        en
        de
      ];
      hostName = "cube.xanderio.de";
      plugins = [
        "archive"
        "zipdownload"
        "managesieve"
        "acl"
        "persistent_login"
      ];
      extraConfig = ''
        $config['imap_host'] = 'ssl://mail.xanderio.de:993';
        $config['smtp_host'] = 'ssl://%h:465';
        $config['managesieve_host'] = 'ssl://%h';
      '';
    };
  };
}
