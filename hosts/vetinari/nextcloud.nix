{ pkgs, config, ... }:
{
  services = {
    postgresql = {
      enable = true;
      ensureDatabases = [ "nextcloud" ];
      ensureUsers = [
        {
          name = "nextcloud";
          ensureDBOwnership = true;
        }
      ];
    };

    nextcloud = {
      enable = true;
      https = true;
      package = pkgs.nextcloud32;
      appstoreEnable = true;
      hostName = "cloud.xanderio.de";
      phpOptions."opcache.interned_strings_buffer" = "32";
      configureRedis = true;
      config = {
        dbtype = "pgsql";
        dbhost = "/run/postgresql";
        adminpassFile = "/etc/nixos/nextcloud-adminpass";
      };
      settings = {
        default_phone_region = "DE";
        "maintenance_window_start" = "1";
      };
    };

    nginx = {
      enable = true;
      virtualHosts."${config.services.nextcloud.hostName}" = {
        enableACME = true;
        forceSSL = true;
      };
    };
  };
}
