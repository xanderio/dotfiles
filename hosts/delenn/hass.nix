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

      "hass.xanderio.de" = {
        enableACME = true;
        forceSSL = true;
        locations =
          let
            upstream = "http://[fd7a:115c:a1e0:ab12:4843:cd96:626e:4b10]:8123";
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
