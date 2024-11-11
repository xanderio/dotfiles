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
      package = pkgs.nextcloud30;
      hostName = "cloud.xanderio.de";
      caching.apcu = true;
      caching.redis = true;
      config = {
        dbtype = "pgsql";
        dbhost = "/run/postgresql";
        adminpassFile = "/etc/nixos/nextcloud-adminpass";
      };
      settings = {
        default_phone_region = "DE";
        "memcache.local" = ''\OC\Memcache\APCu'';
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
