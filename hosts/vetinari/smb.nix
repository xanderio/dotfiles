{ config, ... }:
{
  config = {
    services.samba = {
      enable = true;
      openFirewall = true;
      settings = {
        global = {
          "workgroup" = "WORKGROUP";
          "server string" = "vetinari";
          "netbios name" = "VETINARI";
          "security" = "user";
          #"use sendfile" = "yes";
          #"max protocol" = "smb2";
          # note: localhost is the ipv6 localhost ::1
          # "hosts allow" = "192.168.0. 127.0.0.1 localhost";
          # "hosts deny" = "0.0.0.0/0";
          "guest account" = "nobody";
          "map to guest" = "bad user";
        };
        "public" = {
          "path" = "/var/lib/public";
          "browseable" = "yes";
          "read only" = "no";
          "guest ok" = "yes";
          "create mask" = "0644";
          "directory mask" = "0755";
          "force user" = "xanderio";
          "force group" = "users";
        };
        "paperless" = {
          "path" = "${config.services.paperless.mediaDir}/documents/originals";
          "browseable" = "yes";
          "valid users" = "xanderio";
          "read only" = "no";
          "guest ok" = "no";
          "create mask" = "0644";
          "directory mask" = "0755";
          "force user" = "paperless";
          "force group" = "paperless";
        };
        "paperless-comsume" = {
          "path" = "${config.services.paperless.consumptionDir}";
          "browseable" = "yes";
          "read only" = "no";
          "guest ok" = "yes";
          "create mask" = "0644";
          "directory mask" = "0755";
          "force user" = "paperless";
          "force group" = "paperless";
        };
        "media" = {
          "path" = "/media";
          "browseable" = "yes";
          "read only" = "no";
          "guest ok" = "yes";
          "create mask" = "0644";
          "directory mask" = "0755";
          "force user" = "xanderio";
          "force group" = "users";
        };
        "hass_backup" = {
          "path" = "/srv/hass_backup";
          "browseable" = "no";
          "read only" = "no";
          "guest ok" = "no";
          "create mask" = "0640";
          "directory mask" = "0750";
          "force user" = "hass_backup";
          "force group" = "users";
        };
        "timemachine" = {
          "path" = "/var/lib/timemachine";
          "valid users" = "xanderio";
          "public" = "no";
          "writeable" = "yes";
          "force user" = "xanderio";
          # Below are the most imporant for macOS compatibility
          # Change the above to suit your needs
          "fruit:aapl" = "yes";
          "fruit:time machine" = "yes";
          "vfs objects" = "catia fruit streams_xattr";
        };
      };
    };

    users.users.hass_backup = {
      isNormalUser = true;
      home = "/srv/hass_backup";
    };

    services.samba-wsdd = {
      enable = true;
      openFirewall = true;
    };

    services.resolved.extraConfig = ''
      # conflicts with avahi for mdns service registration
      MulticastDNS=resolve
    '';

    services.avahi = {
      publish.enable = true;
      publish.userServices = true;
      nssmdns4 = true;
      enable = true;
      allowInterfaces = [ "br0" ];
      openFirewall = true;
      extraServiceFiles = {
        timemachine = ''
          <?xml version="1.0" standalone='no'?>
          <!DOCTYPE service-group SYSTEM "avahi-service.dtd">
          <service-group>
            <name replace-wildcards="yes">%h</name>
            <service>
              <type>_smb._tcp</type>
              <port>445</port>
            </service>
              <service>
              <type>_device-info._tcp</type>
              <port>0</port>
              <txt-record>model=TimeCapsule8,119</txt-record>
            </service>
            <service>
              <type>_adisk._tcp</type>
              <txt-record>dk0=adVN=timemachine,adVF=0x82</txt-record>
              <txt-record>sys=waMa=0,adVF=0x100</txt-record>
            </service>
          </service-group>
        '';
      };
    };
  };
}
