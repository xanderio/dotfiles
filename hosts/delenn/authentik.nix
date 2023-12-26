{ inputs, config, lib, ... }: {
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

    systemd.services.authentik-worker.preStart = ''
      ln -svf ${config.services.authentik.authentikComponents.staticWorkdirDeps}/* /run/authentik/
    '';

    services.authentik = {
      enable = true;
      environmentFile = config.sops.templates."authentik-env".path;
      settings = {
        disable_startup_analytics = true;
        avatars = "initials";
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
