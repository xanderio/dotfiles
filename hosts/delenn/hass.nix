{...}: {
  networking = {
    firewall = {
      allowedUDPPorts = [51820];
    };
    wireguard = {
      enable = true;
      interfaces = {
        wg0 = {
          ips = ["10.100.0.1/24"];
          listenPort = 51820;
          privateKeyFile = "/etc/wireguard/hass-private.key";
          generatePrivateKeyFile = true;

          peers = [
            {
              publicKey = "jW5/C2SJFZ1cc97fWr6AEKOex2XJPa5IMU2j6N8nuk4=";
              allowedIPs = ["10.100.0.2/32"];
            }
          ];
        };
      };
    };
  };

  services.nginx.virtualHosts = {
    "home.xanderio.de" = {
      enableACME = true;
      forceSSL = true;
      locations = let
      in {
        "/" = {
          proxyPass = "http://10.100.0.2:8123";
        };
        "/api/websocket" = {
          proxyWebsockets = true;
          proxyPass = "http://10.100.0.2:8123";
        };
      };
    };
  };
}
