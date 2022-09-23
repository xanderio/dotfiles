{ pkgs
, config
, ...
}:
let
  woodpeckerserver = config.users.users.woodpeckerserver.name;
in
{
  systemd.services.woodpecker-server = {
    wantedBy = [ "multi-user.target" ];
    requires = [ "postgresql.service" ];
    serviceConfig = {
      EnvironmentFile = [
        config.age.secrets.woodpecker.path
      ];
      Environment = [
        "WOODPECKER_DATABASE_DATASOURCE=postgres:///woodpeckerserver?host=/run/postgresql"
        "WOODPECKER_DATABASE_DRIVER=postgres"
        "WOODPECKER_SERVER_ADDR=:3030"
        "WOODPECKER_ADMIN=xanderio"
        "WOODPECKER_HOST=https://woodpecker.xanderio.de"
      ];
      ExecStart = "${pkgs.woodpecker-server}/bin/woodpecker-server";
      User = woodpeckerserver;
      Group = woodpeckerserver;
    };
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [ woodpeckerserver ];
    ensureUsers = [
      {
        name = woodpeckerserver;
        ensurePermissions = {
          "DATABASE ${woodpeckerserver}" = "ALL PRIVILEGES";
        };
      }
    ];
  };

  services.nginx = {
    enable = true;
    virtualHosts."woodpecker.xanderio.de" = {
      enableACME = true;
      forceSSL = true;
      locations."/".extraConfig = ''
        proxy_pass http://localhost:3030;
      '';
    };
  };

  users.users.woodpeckerserver = {
    isSystemUser = true;
    createHome = true;
    group = woodpeckerserver;
  };
  users.groups.woodpeckerserver = { };
}
