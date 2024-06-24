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
      package = pkgs.nextcloud29;
      hostName = "cloud.xanderio.de";
      caching.apcu = true;
      caching.redis = true;
      extraOptions = {
        "memcache.local" = ''\OC\Memcache\APCu'';
      };
      config = {
        dbtype = "pgsql";
        dbhost = "/run/postgresql";
        adminpassFile = "/etc/nixos/nextcloud-adminpass";
        defaultPhoneRegion = "DE";
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
