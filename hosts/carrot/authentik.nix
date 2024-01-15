{ inputs, config, ... }: {
  imports = [
    inputs.authentik.nixosModules.default
  ];

  config = {
    x.sops.secrets = {
      "services/authentik/secret_key" = { };
      "services/authentik/email_password" = { };
    };

    sops.templates."authentik-env".content = ''
      AUTHENTIK_SECRET_KEY="${config.sops.placeholder."services/authentik/secret_key"}"
      AUTHENTIK_EMAIL__PASSWORD="${config.sops.placeholder."services/authentik/email_password"}"
    '';

    systemd.services.authentik.preStart = ''
      mkdir -p /var/lib/authentik/media
    '';

    services.authentik = {
      enable = true;
      environmentFile = config.sops.templates."authentik-env".path;
      settings = {
        disable_startup_analytics = true;
        avatars = "initials";
        paths.media = "/var/lib/authentik/media";
        media.enable_upload = true;
        email = {
          host = "smtp.mailbox.org";
          port = 587;
          username = "alex@xanderio.de";
          use_tls = true;
          use_ssl = false;
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
