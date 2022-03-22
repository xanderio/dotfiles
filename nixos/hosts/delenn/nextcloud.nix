{ options, ... }:
{
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "nextcloud" ];
    ensureUsers = [
      {
        name = "nextcloud";
        ensurePermissions = {
          "DATABASE nextcloud" = "ALL PRIVILEGES";
        };
      }
    ];
  };

  services.nextcloud = {
    enable = true;
    hostName = "cloud.xanderio.de";
    datadir = "/mnt/nextcloud";
    config = {
      dbtype = "pgsql";
      dbhost = "/run/postgresql";
      adminpassFile = "/etc/nixos/nextcloud-adminpass";
    };
  };
  services.nginx.virtualHosts."cloud.xanderio.de" = {
    enableACME = true;
    forceSSL = true;
  };
}
