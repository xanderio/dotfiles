{...}: {
  services.nginx.virtualHosts = {
    "home.xanderio.de" = {
      enableACME = true;
      forceSSL = true;
      locations = let
        upstream = "http://hal9000.internal.hs.xanderio.de:8123";
      in {
        "/" = {
          proxyPass = upstream;
        };
        "/api/websocket" = {
          proxyWebsockets = true;
          proxyPass = upstream;
        };
      };
    };
  };
}
