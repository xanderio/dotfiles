{ config, ... }: {
  config = {
    services.nginx = {
      enable = true;
      virtualHosts."audiobook.xanderio.de" = {
        enableACME = true;
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://${config.services.audiobookshelf.host}:${toString config.services.audiobookshelf.port}";
          proxyWebsockets = true;
        };
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
  };
}
