{ ... }: {
  systemd.services.nginx = {
    requires = [ "tailscaled.service" ];
    after = [ "tailscaled.service" ];
  };
  services.nginx = {
    validateConfig = false;
    virtualHosts = {
      "home.xanderio.de" = {
        enableACME = true;
        forceSSL = true;
        locations =
          let
            upstream = "http://hal9000.tail2f592.ts.net:8123";
          in
          {
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
  };
}
