{ pkgs, ... }: {
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
      package = pkgs.nextcloud27;
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
        trustedProxies = [ "fd7a:115c:a1e0:ab12:4843:cd96:6257:8868" ];
        defaultPhoneRegion = "DE";
      };
    };
  };
}
