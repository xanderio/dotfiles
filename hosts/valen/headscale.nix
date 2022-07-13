{config, ...}: {
  services = {
    headscale = {
      enable = true;
      address = "0.0.0.0";
      settings = {
        metrics_listen_addr = "127.0.0.1:8081";
        ip_prefixes = [
          "fd7a:115c:a1e0::/48"
          "100.64.0.0/10"
        ];
      };
      dns = {
        baseDomain = "hs.xanderio.de";
        magicDns = true;
        domains = ["xanderio.de" "home.hs.xanderio.de"];
        nameservers = [
          "9.9.9.9"
        ];
      };
      port = 8085;
      serverUrl = "https://headscale.xanderio.de";
    };
    nginx.virtualHosts = let
      location = "http://localhost:${toString config.services.headscale.port}";
    in {
      "headscale.xanderio.de" = {
        forceSSL = true;
        enableACME = true;
        locations."/".proxyPass = location;
      };
    };
  };
  systemd.services."headscale".environment = {
    GIN_MODE = "release";
  };
  environment.systemPackages = [config.services.headscale.package];
}
