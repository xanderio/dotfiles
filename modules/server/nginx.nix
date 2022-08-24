{ config
, lib
, ...
}: {
  networking.firewall.allowedTCPPorts =
    lib.mkIf config.services.nginx.enable [ 80 443 ];

  services = {
    nginx = {
      enableReload = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
    };
  };
}
