{ config, lib, ... }:
{

  config = {
    networking.firewall.allowedTCPPorts = lib.mkIf config.services.nginx.enable [
      80
      443
    ];

    services = {
      nginx = {
        enableReload = true;
        recommendedGzipSettings = true;
        recommendedOptimisation = true;
        recommendedProxySettings = true;
        recommendedTlsSettings = true;
        appendHttpConfig = ''
          access_log /var/log/nginx/$server_name-access.log combined;
        '';
      };
    };
  };
}
