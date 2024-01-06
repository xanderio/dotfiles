{ lib, pkgs, config, ... }:
let
  fqdn = "bitflip.jetzt";
  turnRealm = "turn.${fqdn}";
  syncv3Domain = "syncv3.${fqdn}";
  clientConfig = {
    "m.homeserver".base_url = "https://${fqdn}";
    "m.identity_server".base_url = "https://vector.im";
    "org.matrix.msc3575.proxy".url = "https://${syncv3Domain}";
  };
  serverConfig."m.server" = "${config.services.matrix-synapse.settings.server_name}:443";
  mkWellKnown = data: ''
    add_header Content-Type application/json;
    add_header Access-Control-Allow-Origin *;
    return 200 '${builtins.toJSON data}';
  '';
in
{
  x.sops.secrets = {
    "services/synapse/signing_key".owner = "matrix-synapse";
    "services/synapse/registration_shared_secret".owner = "matrix-synapse";
    "services/synapse/sliding_sync_env".owner = "root";
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
      locations."/_matrix".proxyPass = "http://[::1]:8008";
      locations."/_synapse/client".proxyPass = "http://[::1]:8008";
    };
    virtualHosts."${turnRealm}" = {
      enableACME = true;
      forceSSL = true;
      locations."/".extraConfig = ''
        return 404;
      '';
    };
    virtualHosts."${syncv3Domain}" = {
      enableACME = true;
      forceSSL = true;
      locations."/".proxyPass = "http://${config.services.matrix-sliding-sync.settings.SYNCV3_BINDADDR}";
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
    allowedUDPPortRanges = [{
      from = config.services.coturn.min-port;
      to = config.services.coturn.max-port;
    }];
  };


  x.sops.secrets = {
    "services/synapse/oidc_secret" = { };
  };

  sops.templates."synapse-oidc" = {
    owner = "matrix-synapse";
    content = builtins.toJSON {
      oidc_providers = [
        {
          idp_id = "authentik";
          idp_name = "authentik";
          discover = true;
          issuer = "https://sso.xanderio.de/application/o/synapse/";
          client_id = "synapse";
          client_secret = config.sops.placeholder."services/synapse/oidc_secret";
          scopes = [ "openid" "profile" "email" ];
          user_mapping_provider.config = {
            localpart_template = "{{ user.username }}";
            display_name_template = "{{ user.preferred_username }}";
          };
          allow_existing_users = true;
        }
      ];
    };
  };

  services.matrix-synapse = {
    enable = true;
    withJemalloc = true;
    extraConfigFiles = [
      config.sops.templates."synapse-oidc".path
    ];
    extras = [
      "oidc"
    ];
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
          resources = [{
            names = [ "client" "federation" ];
            compress = true;
          }];
        }
        {
          port = 8088;
          bind_addresses = [ "::1" "100.73.157.55" "fd7a:115c:a1e0::d309:9d37" ];
          type = "http";
          tls = false;
          x_forwarded = true;
          resources = [{
            names = [ "metrics" ];
            compress = true;
          }];
        }
      ];
      registration_shared_secret_path = config.sops.secrets."services/synapse/registration_shared_secret".path;
      turn_uris = [
        "turn:${turnRealm}:${toString config.services.coturn.listening-port}?transport=udp"
        "turn:${turnRealm}:${toString config.services.coturn.listening-port}?transport=tcp"
      ];
      turn_shared_secret = config.services.coturn.static-auth-secret;
      turn_user_lifetime = "86400000";
      password_config.enabled = false;
      extraConfig = ''
        turn_allow_guests: True
      '';
    };
  };

  services.matrix-sliding-sync = {
    enable = true;
    environmentFile = config.sops.secrets."services/synapse/sliding_sync_env".path;
    settings = {
      SYNCV3_SERVER = "https://bitflip.jetzt";
      SYNCV3_BINDADDR = "[::]:8009";
      SYNCV3_LOG_LEVEL = "error";
    };
  };

  # remove chmod for signing-key file
  systemd.services.matrix-synapse.serviceConfig.ExecStartPre = lib.mkForce [ ];
}
