{
  lib,
  pkgs,
  config,
  ...
}:
let
  fqdn = "bitflip.jetzt";
  turnRealm = "turn.${fqdn}";
  clientConfig = {
    "m.homeserver".base_url = "https://${fqdn}";
    "m.identity_server".base_url = "https://vector.im";
    "org.matrix.msc2965.authentication" = {
      issuer = "https://auth-matrix.cyberus-technology.de/";
      account = "https://auth-matrix.cyberus-technology.de/account";
    };
  };
  serverConfig."m.server" = "${config.services.matrix-synapse.settings.server_name}:443";
  mkWellKnown = data: ''
    default_type application/json;
    add_header Access-Control-Allow-Origin *;
    return 200 '${builtins.toJSON data}';
  '';
in
{
  imports = [
    ./matrix-authentication-services.nix
  ];

  nixpkgs.config.packageOverrides = pkgs: {
    coturn = pkgs.coturn.overrideAttrs (_: {
      dontCheckForBrokenSymlinks = true;
    });
    roundcube = pkgs.roundcube.overrideAttrs (_: {
      dontCheckForBrokenSymlinks = true;
    });
  };

  x.sops.secrets = {
    "services/synapse/signing_key".owner = "matrix-synapse";
    "services/synapse/macaroon_secret_key" = { };
    "services/synapse/registration_shared_secret".owner = "matrix-synapse";
    "services/mas-synapse/client_secret" = { };
    "services/mas-synapse/homeserver_secret" = { };
  };

  networking.firewall.interfaces."tailscale0".allowedTCPPorts = [ 8088 ];

  services.postgresql = {
    enable = true;
    initialScript = pkgs.writeText "synapse-init.sql" ''
      CREATE ROLE "matrix-synapse" WITH LOGIN PASSWORD 'synapse';
      CREATE DATABASE "matrix-synapse" WITH OWNER "matrix-synapse"
        TEMPLATE template0
        LC_COLLATE = "C"
        LC_CTYPE = "C";
    '';
  };

  services.nginx = {
    enable = true;
    virtualHosts."${fqdn}" = {
      enableACME = true;
      forceSSL = true;
      locations."= /.well-known/matrix/server".extraConfig = mkWellKnown serverConfig;
      locations."= /.well-known/matrix/client".extraConfig = mkWellKnown clientConfig;
      locations."/".extraConfig = ''
        return 404;
      '';
      locations."~ ^/_matrix/client/(.*)/(login|logout|refresh)" = {
        proxyPass = "http://[::]:8085";
        extraConfig = ''
          proxy_http_version 1.1;
        '';
      };
      locations."/_matrix" = {
        proxyPass = "http://[::1]:8008";
        extraConfig = ''
          client_max_body_size 1G;
        '';
      };
      locations."/_synapse" = {
        proxyPass = "http://[::1]:8008";
        extraConfig = ''
          gzip off;
        '';
      };
    };
    virtualHosts."${turnRealm}" = {
      enableACME = true;
      forceSSL = true;
      locations."/".extraConfig = ''
        return 404;
      '';
    };
  };

  services.coturn = {
    enable = true;

    use-auth-secret = true;
    static-auth-secret = "842a5b19b65160f09e9bc05e244d00d50593c130dc64776854c20ca1d0a4adf4";
    realm = turnRealm;

    # VoIP traffic is all UDP. There is no reason to let users connect to arbitrary TCP endpoints via the relay.
    no-tcp-relay = true;

    extraConfig = ''
      # don't let the relay ever try to connect to private IP address ranges within your network (if any)
      # given the turn server is likely behind your firewall, remember to include any privileged public IPs too.
      denied-peer-ip=10.0.0.0-10.255.255.255
      denied-peer-ip=192.168.0.0-192.168.255.255
      denied-peer-ip=172.16.0.0-172.31.255.255
      allowed-peer-ip=10.67.3.13
      # consider whether you want to limit the quota of relayed streams per user (or total) to avoid risk of DoS.
      user-quota=12 # 4 streams per video call, so 12 streams = 3 simultaneous relayed calls per user.
      total-quota=1200
    '';
    cert = "/var/lib/acme/${turnRealm}/fullchain.pem";
    pkey = "/var/lib/acme/${turnRealm}/key.pem";
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      80
      443
      config.services.coturn.listening-port
      config.services.coturn.tls-listening-port
    ];
    allowedUDPPorts = [
      config.services.coturn.listening-port
      config.services.coturn.tls-listening-port
    ];
    allowedUDPPortRanges = [
      {
        from = config.services.coturn.min-port;
        to = config.services.coturn.max-port;
      }
    ];
  };

  x.sops.secrets = {
    "services/synapse/oidc_secret" = { };
  };

  sops.templates."synapse-mas" = {
    owner = "matrix-synapse";
    restartUnits = [ "matrix-synapse.service" ];
    content = builtins.toJSON {
      macaroon_secret_key = config.sops.placeholder."services/synapse/macaroon_secret_key";
      experimental_features = {
        msc4076_enabled = true;
        msc4108_enabled = true;
        msc3861 = {
          enabled = true;
          client_id = "0000000000000000000SYNAPSE";
          issuer = "https://mas.bitflip.jetzt/";
          client_auth_method = "client_secret_basic";
          client_secret = config.sops.placeholder."services/mas-synapse/client_secret";
          admin_token = config.sops.placeholder."services/mas-synapse/homeserver_secret";
          account_management_url = "https://mas.bitflip.jetzt/account";
        };
      };
    };
  };

  services.matrix-synapse = {
    enable = true;
    withJemalloc = true;
    extraConfigFiles = [ config.sops.templates."synapse-mas".path ];
    extras = [ "oidc" ];
    settings = {
      server_name = fqdn;
      public_baseurl = "https://${fqdn}";
      enable_metrics = true;
      signing_key_path = config.sops.secrets."services/synapse/signing_key".path;
      listeners = [
        {
          port = 8008;
          bind_addresses = [ "::1" ];
          type = "http";
          tls = false;
          x_forwarded = true;
          resources = [
            {
              names = [
                "client"
                "federation"
              ];
              compress = true;
            }
          ];
        }
        {
          port = 8088;
          bind_addresses = [
            "::1"
            "100.73.157.55"
            "fd7a:115c:a1e0::d309:9d37"
          ];
          type = "http";
          tls = false;
          x_forwarded = true;
          resources = [
            {
              names = [ "metrics" ];
              compress = true;
            }
          ];
        }
      ];
      registration_shared_secret_path =
        config.sops.secrets."services/synapse/registration_shared_secret".path;
      turn_uris = [
        "turn:${turnRealm}:${toString config.services.coturn.listening-port}?transport=udp"
        "turn:${turnRealm}:${toString config.services.coturn.listening-port}?transport=tcp"
      ];
      turn_allow_guests = true;
      turn_shared_secret = config.services.coturn.static-auth-secret;
      turn_user_lifetime = "86400000";
      password_config.enabled = false;

      user_directory = {
        search_all_users = true;
        prefer_local_users = true;
      };
    };
  };
}
