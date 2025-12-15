{
  pkgs,
  config,
  ...
}:
{
  systemd.services."netns@" = {
    description = "%I network namespace";
    before = [ "network.target" ];
    path = [ pkgs.iproute2 ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.iproute2}/bin/ip netns add %I";
      ExecStop = "${pkgs.iproute2}/bin/ip netns del %I";
    };
  };

  systemd.services.ffka = {
    description = "ffka network interface";
    bindsTo = [ "netns@ffka.service" ];
    requires = [ "network-online.target" ];
    after = [ "netns@ffka.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart =
        with pkgs;
        writers.writeBash "ffka-up" ''
          set -e
          ${pkgs.iproute2}/bin/ip link add link enp4s0 name enp4s0.1007 type vlan id 1007
          ${pkgs.iproute2}/bin/ip link set enp4s0.1007 netns ffka
          ${pkgs.iproute2}/bin/ip netns exec ffka ${pkgs.dhcpcd}/bin/dhcpcd enp4s0.1007 
          # need to set lo up as network namespace is started with lo down
          ${pkgs.iproute2}/bin/ip -n ffka link set lo up
        '';
      ExecStop =
        with pkgs;
        writers.writeBash "ffka-down" ''
          ${pkgs.iproute2}/bin/ip -n ffka route del default dev enp4s0.1007
          ${pkgs.iproute2}/bin/ip -n ffka -6 route del default dev enp4s0.1007
          ${pkgs.iproute2}/bin/ip -n ffka link del enp4s0.1007
        '';
    };
  };

  systemd.sockets."proxy-to-qbittorrent" = {
    enable = true;
    description = "Socket for Proxy to QBitTorrent Daemon";
    listenStreams = [ "${toString config.services.qbittorrent.webuiPort}" ];
    wantedBy = [ "sockets.target" ];
  };

  systemd.services."proxy-to-qbittorrent" = {
    enable = true;
    description = "Proxy to QBitTorrent Daemon in Network Namespace";
    requires = [
      "qbittorrent.service"
      "proxy-to-qbittorrent.socket"
    ];
    after = [
      "qbittorrent.service"
      "proxy-to-qbittorrent.socket"
    ];
    unitConfig = {
      JoinsNamespaceOf = "qbittorrent.service";
    };
    serviceConfig = {
      Type = "notify";
      User = config.services.qbittorrent.user;
      Group = config.services.qbittorrent.group;
      ExecStart = "${pkgs.systemd}/lib/systemd/systemd-socket-proxyd --exit-idle-time=5min 127.0.0.1:${toString config.services.qbittorrent.webuiPort}";
      PrivateTmp = true;
      PrivateNetwork = true;
    };
  };

  environment.etc."netns/ffka/resolv.conf".text = ''
    nameserver 2001:678:6e3:40d::64:64
    nameserver 2001:678:6e3:40d::2
    nameserver 45.140.183.40
    nameserver 45.140.183.41

  '';

  systemd.services.qbittorrent.bindsTo = [ "netns@ffka.service" ];
  systemd.services.qbittorrent.requires = [
    "network-online.target"
    "ffka.service"
  ];
  systemd.services.qbittorrent.serviceConfig = {
    NetworkNamespacePath = [ "/var/run/netns/ffka" ];
    PrivateMounts = true;
    BindReadOnlyPaths = [ "/etc/netns/ffka/resolv.conf:/etc/resolv.conf:norbind" ];
  };

  systemd.tmpfiles.settings."10-downloads"."/tank/downloads".d = {
    user = "${config.services.qbittorrent.user}";
    group = "${config.services.qbittorrent.group}";
    mode = "0775";
  };
  systemd.tmpfiles.settings."10-downloads"."/tank/incomplete".d = {
    user = "${config.services.qbittorrent.user}";
    group = "${config.services.qbittorrent.group}";
    mode = "0775";
  };

  services.qbittorrent = {
    enable = true;
    group = "media";
    extraArgs = [ "--confirm-legal-notice" ];
  };

  users.users.xanderio.extraGroups = [ "media" ];
  users.groups.media = { };

  services.flood.enable = true;

  services.sonarr = {
    enable = true;
    group = "media";
  };
  services.radarr = {
    enable = true;
    group = "media";
  };
  services.readarr = {
    enable = true;
    group = "media";
  };
  services.bazarr = {
    enable = true;
    group = "media";
  };
  services.prowlarr = {
    enable = true;
  };

  services.nginx = {
    enable = true;
    virtualHosts = {
      "bazarr.xanderio.de" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://localhost:${toString config.services.bazarr.listenPort}";
        };
      };
      "sonarr.xanderio.de" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://localhost:8989";
        };
      };
      "radarr.xanderio.de" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://localhost:7878";
        };
      };
      "readarr.xanderio.de" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://localhost:8787";
        };
      };
      "prowlarr.xanderio.de" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://localhost:9696";
        };
      };
      "flood.xanderio.de" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://localhost:3000";
        };
      };
      "qbittorrent.xanderio.de" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://localhost:${toString config.services.qbittorrent.webuiPort}";
        };
      };
    };
  };
}
