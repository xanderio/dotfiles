{ pkgs, ... }: {
  services = {
    postgresql = {
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

    nextcloud = {
      enable = true;
      https = true;
      enableBrokenCiphersForSSE = false;
      package = pkgs.nextcloud27;
      hostName = "cloud.xanderio.de";
      config = {
        dbtype = "pgsql";
        dbhost = "/run/postgresql";
        adminpassFile = "/etc/nixos/nextcloud-adminpass";
      };
    };
  };
}
