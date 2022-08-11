{ lib, ... }: {
  services.miniflux = {
    enable = true;
    adminCredentialsFile = "/dev/null";
    config = {
      CREATE_ADMIN = lib.mkForce "0";
      FETCH_YOUTUBE_WATCH_TIME = "on";
    };
  };
  services.nginx.virtualHosts = {
    "miniflux.xanderio.de" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:8080/";
      };
    };
  };
}
