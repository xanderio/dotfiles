{ config, ... }:
{
  config = {
    services.borgbackup.jobs.backup.exclude = [
      "/var/lib/audiobookshelf/libary"
      "/var/lib/audiobookshelf/metadata/cache"
    ];
    services.nginx = {
      enable = true;
      virtualHosts."audiobook.xanderio.de" = {
        enableACME = true;
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://${config.services.audiobookshelf.host}:${toString config.services.audiobookshelf.port}";
          proxyWebsockets = true;
        };
        extraConfig = ''
          client_max_body_size 5G;
        '';
      };
    };

    fileSystems."/var/lib/audiobookshelf/libary" = {
      device = "/media/audiobooks";
      depends = [ "/media/audiobooks" ];
      options = [ "bind" ];
    };

    services.audiobookshelf = {
      enable = true;
    };

    systemd.services.audiobookshelf.serviceConfig.SupplementaryGroups = [ "users" ];

  };
}
