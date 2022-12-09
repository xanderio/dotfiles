{ lib, pkgs, config, ... }:
let
  fqdn = "bitflip.jetzt";
  clientConfig = {
    "m.homeserver".base_url = "https://${fqdn}";
    "m.identity_server" = { };
  };
  serverConfig."m.server" = "${config.services.matrix-synapse.settings.server_name}:443";
  mkWellKnown = data: ''
    add_header Content-Type application/json;
    add_header Access-Control-Allow-Origin *;
    return 200 '${builtins.toJSON data}';
  '';
in
{
  age.secrets = {
    signing-key = {
      owner = "matrix-synapse";
      file = ../../secrets/synapse-signing-key.age;
    };
    registration-shared-secret = {
      owner = "matrix-synapse";
      file = ../../secrets/synapse-registration_shared_secret.age;
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
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
  };

  services.matrix-synapse = {
    enable = true;
    withJemalloc = true;
    settings = {
      server_name = fqdn;
      public_baseurl = "https://${fqdn}";
      enable_metrics = true;
      signing_key_path = config.age.secrets.signing-key.path;
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
          bind_addresses = [ "::1" "100.87.136.104" "fd7a:115c:a1e0:ab12:4843:cd96:6257:8868" ];
          type = "http";
          tls = false;
          x_forwarded = true;
          resources = [{
            names = [ "metrics" ];
            compress = true;
          }];
        }
      ];
      registration_shared_secret_path = config.age.secrets.registration-shared-secret.path;
    };
  };

  # remove chmod for signing-key file
  systemd.services.matrix-synapse.serviceConfig.ExecStartPre = lib.mkForce [ ];
}
