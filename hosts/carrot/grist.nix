{ config, ... }: {
  config = {
    x.sops.secrets."services/grist/env" = {
      group = "${config.virtualisation.oci-containers.backend}";
      mode = "0440";
    };

    virtualisation.oci-containers.containers.grist = {
      image = "gristlabs/grist";
      autoStart = true;
      environment = {
        APP_HOME_URL = "https://grist.xanderio.de";
        GRIST_OIDC_IDP_ISSUER = "https://sso.xanderio.de/application/o/grist/.well-known/openid-configuration";
        GRIST_OIDC_IDP_CLIENT_ID = "grist";
        GRIST_FORCE_LOGIN = "1";
      };
      environmentFiles = [
        config.sops.secrets."services/grist/env".path
      ];

      volumes = [ "/var/lib/grist:/persist" ];
      ports = [ "8484:8484" ];
    };

    systemd.services."${config.virtualisation.oci-containers.backend}-grist".serviceConfig = {
      StateDirectory = "grist";
    };

    services.nginx.virtualHosts."grist.xanderio.de" = {
      enableACME = true;
      forceSSL = true;
      kTLS = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8484";
        proxyWebsockets = true;
      };
    };
  };
}
