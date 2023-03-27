{ pkgs, config, ... }: {
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
      package = pkgs.nextcloud26;
      hostName = "cloud.xanderio.de";
      datadir = "/mnt/nextcloud";
      config = {
        dbtype = "pgsql";
        dbhost = "/run/postgresql";
        adminpassFile = "/etc/nixos/nextcloud-adminpass";
      };
    };
    nginx.virtualHosts."cloud.xanderio.de" = {
      enableACME = true;
      forceSSL = true;
    };
  };
}
