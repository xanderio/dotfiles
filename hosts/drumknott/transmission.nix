{
  pkgs,
  lib,
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

  systemd.services.wg = {
    description = "wg network interface";
    bindsTo = [ "netns@wg.service" ];
    requires = [ "network-online.target" ];
    after = [ "netns@wg.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart =
        with pkgs;
        writers.writeBash "wg-up" ''
          set -e
          ${pkgs.iproute2}/bin/ip link add wg0 netns wg type wireguard
          ${pkgs.iproute2}/bin/ip -n wg address add 10.70.132.89/32 dev wg0
          ${pkgs.iproute2}/bin/ip -n wg -6 address add fc00:bbbb:bbbb:bb01::7:8458/128 dev wg0
          ${pkgs.iproute2}/bin/ip netns exec wg ${pkgs.wireguard-tools}/bin/wg setconf wg0 /root/mullvad.conf
          ${pkgs.iproute2}/bin/ip -n wg link set wg0 up
          # need to set lo up as network namespace is started with lo down
          ${pkgs.iproute2}/bin/ip -n wg link set lo up
          ${pkgs.iproute2}/bin/ip -n wg route add default dev wg0
          ${pkgs.iproute2}/bin/ip -n wg -6 route add default dev wg0
        '';
      ExecStop =
        with pkgs;
        writers.writeBash "wg-down" ''
          ${pkgs.iproute2}/bin/ip -n wg route del default dev wg0
          ${pkgs.iproute2}/bin/ip -n wg -6 route del default dev wg0
          ${pkgs.iproute2}/bin/ip -n wg link del wg0
        '';
    };
  };

  systemd.sockets."proxy-to-transmission" = {
    enable = true;
    description = "Socket for Proxy to Transmission Daemon";
    listenStreams = [ "9091" ];
    wantedBy = [ "sockets.target" ];
  };

  systemd.services."proxy-to-transmission" = {
    enable = true;
    description = "Proxy to Transmission Daemon in Network Namespace";
    requires = [
      "transmission.service"
      "proxy-to-transmission.socket"
    ];
    after = [
      "transmission.service"
      "proxy-to-transmission.socket"
    ];
    unitConfig = {
      JoinsNamespaceOf = "transmission.service";
    };
    serviceConfig = {
      Type = "notify";
      User = config.services.transmission.user;
      Group = config.services.transmission.group;
      ExecStart = "${pkgs.systemd}/lib/systemd/systemd-socket-proxyd --exit-idle-time=5min 127.0.0.1:9091";
      PrivateTmp = true;
      PrivateNetwork = true;
    };
  };

  environment.etc."netns/wg/resolv.conf".text = ''
    nameserver 10.64.0.1
  '';

  systemd.services.transmission.bindsTo = [ "netns@wg.service" ];
  systemd.services.transmission.requires = [
    "network-online.target"
    "wg.service"
  ];
  systemd.services.transmission.serviceConfig =
    {
      NetworkNamespacePath = [ "/var/run/netns/wg" ];
      PrivateMounts = true;
      BindReadOnlyPaths = [ "/etc/netns/wg/resolv.conf:/etc/resolv.conf:norbind" ];
    };

  systemd.tmpfiles.settings."10-downloads"."/tank/downloads".d = {
    user = "transmission";
    group = "media";
    mode = "0775";
  };
  systemd.tmpfiles.settings."10-downloads"."/tank/incomplete".d = {
    user = "transmission";
    group = "media";
    mode = "0775";
  };

  services.transmission = {
    enable = true;
    package = pkgs.transmission_4;
    group = "media";
    webHome = pkgs.flood-for-transmission;
    downloadDirPermissions = "775";
    settings = {
      rpc-bind-address = "0.0.0.0";
      incomplete-dir = "/tank/incomplete";
      download-dir = "/tank/downloads";
    };
  };

  users.users.xanderio.extraGroups = ["media"];
  users.groups.media = {};

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
    };
  };
}
