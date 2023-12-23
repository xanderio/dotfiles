{ config, pkgs, ... }:
let
  fetchFritzBox = pkgs.writeShellApplication {
    name = "fetch-ip-from-fritz-box";
    runtimeInputs = [ pkgs.curl ];
    text = ''
      # Set default hostname to connect to the FritzBox
      : "''${FRITZ_BOX_HOSTNAME:=fritz.box}"

      curl -s -H 'Content-Type: text/xml; charset="utf-8"' \
        -H 'SOAPAction: urn:schemas-upnp-org:service:WANIPConnection:1#GetExternalIPAddress' \
        -d '<?xml version="1.0" encoding="utf-8"?><s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" s:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"> <s:Body> <u:GetExternalIPAddress xmlns:u="urn:schemas-upnp-org:service:WANIPConnection:1" /></s:Body></s:Envelope>' \
        "http://$FRITZ_BOX_HOSTNAME:49000/igdupnp/control/WANIPConn1" | \
        grep -Eo '\<[[:digit:]]{1,3}(\.[[:digit:]]{1,3}){3}\>'
    '';
  };
in
{
  config = {
    x.sops.secrets = {
      "services/ddclient/password".owner = "root";
    };

    services.ddclient = {
      enable = true;
      package = pkgs.ddclient.overrideAttrs (old: {
        patches = old.patches or [ ] ++ [ ./ddclient_inwx.patch ];
      });
      domains = [ "dyndns.xanderio.de" ];
      server = "dyndns.inwx.com";
      username = "xanderio_fritzbox";
      passwordFile = config.sops.secrets."services/ddclient/password".path;
      verbose = true;
      extraConfig = ''
        usev4=cmdv4, cmdv4=${fetchFritzBox}/bin/fetch-ip-from-fritz-box
        usev6=ifv6, ifv6=eno1
      '';
    };

    systemd.services.ddclient.path = [ pkgs.iproute2 ];
  };
}
