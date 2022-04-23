{...}: {
  services.miniflux = {
    enable = false;
    config = {
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
