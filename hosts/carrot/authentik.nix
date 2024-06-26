{ inputs, config, ... }:
{
  imports = [ inputs.authentik.nixosModules.default ];

  config = {
    x.sops.secrets = {
      "services/authentik/secret_key" = { };
      "services/authentik/email_password" = { };
    };

    sops.templates."authentik-env".content = ''
      AUTHENTIK_SECRET_KEY="${config.sops.placeholder."services/authentik/secret_key"}"
      AUTHENTIK_EMAIL__PASSWORD="${config.sops.placeholder."services/authentik/email_password"}"
    '';

    systemd.services.authentik.requires = [ "network-online.target" ];

    services.authentik = {
      enable = true;
      environmentFile = config.sops.templates."authentik-env".path;
      settings = {
        disable_startup_analytics = true;
        avatars = "initials";
        paths.media = "/var/lib/authentik/media";
        media.enable_upload = true;
        email = {
          host = "mail.xanderio.de";
          port = 465;
          username = "authentik";
          use_tls = false; # STARTTLS
          use_ssl = true; # implicited SSL/TLS
          from = "authentik@xanderio.de";
        };
      };

      nginx = {
        enable = true;
        enableACME = true;
        host = "sso.xanderio.de";
      };
    };
  };
}
