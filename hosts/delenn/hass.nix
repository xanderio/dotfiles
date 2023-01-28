{ ... }: {
  systemd.services.nginx = {
    requires = [ "tailscaled.service" ];
    after = [ "tailscaled.service" ];
  };
  services.nginx = {
    virtualHosts = {
      "home.xanderio.de" = {
        enableACME = true;
        forceSSL = true;
        locations =
          let
            upstream = "http://100.97.68.57:8123";
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
