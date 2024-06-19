{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.services.ntfy;

  configFormat = pkgs.formats.yaml { };
  configFile = configFormat.generate "server.yaml" cfg.settings;
in
{
  options.services.ntfy = {
    enable = mkEnableOption "ntfy";

    package = mkOption {
      type = types.package;
      default = pkgs.ntfy-sh;
    };

    domain = mkOption { type = types.str; };

    port = mkOption {
      type = types.port;
      default = 8081;
    };

    auth = mkOption {
      type = types.path;
      default = "/var/lib/ntfy";
    };

    attachmentCache = mkOption {
      type = types.path;
      default = "/var/cache/ntfy/attachments";
    };

    cache = mkOption {
      type = types.path;
      default = "/var/cache/ntfy";
    };

    settings = mkOption {
      type = types.submodule {
        freeformType = configFormat.type;

        options = { };
      };
    };
  };

  config = mkIf cfg.enable {
    services.ntfy.settings = {
      cache-file = "${cfg.cache}/cache.db";
      attachment-cache-location = cfg.attachmentCache;
      auth-file = "${cfg.auth}/user.db";
      behind-proxy = true;
      listen-http = ":${builtins.toString cfg.port}";
      base-url = "https://${cfg.domain}";
    };

    users.users.ntfy = {
      group = "ntfy";
      createHome = false;
      isSystemUser = true;
    };

    users.groups.ntfy = { };

    systemd.tmpfiles.rules = [
      "d ${cfg.cache}            0700 ntfy - - -"
      "d ${cfg.attachmentCache}  0700 ntfy - - -"
      "d ${cfg.auth}             0700 ntfy - - -"
    ];

    environment = {
      etc."ntfy/server.yml".source = configFile;
      systemPackages = [ cfg.package ];
    };

    systemd.services.ntfy = {
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      serviceConfig = {
        User = "ntfy";
        Group = "ntfy";
        ExecStart = "${cfg.package}/bin/ntfy serve --no-log-dates";
        ExecReload = "${pkgs.coreutils}/bin/kill --signal HUP $MAINPID";
        Restart = "on-failure";
        AmbientCapabilities = "CAP_NET_BIND_SERVICE";
        LimitNOFILE = 10000;
        StateDirectory = "ntfy";
        CacheDirectory = "ntfy";
      };
      reloadTriggers = [ configFile ];
    };

    services.nginx.virtualHosts.${cfg.domain} = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:${builtins.toString cfg.port}/";
        proxyWebsockets = true;
      };
    };
  };
}
