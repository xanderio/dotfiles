{ inputs, config, ... }: {
  imports = [
    inputs.authentik.nixosModules.default
  ];

  config = {
    x.sops.secrets = {
      "services/authentik/secret_key" = { };
    };

    sops.templates."authentik-env".content = ''
      AUTHENTIK_SECRET_KEY="${config.sops.placeholder."services/authentik/secret_key"}"
    '';

    services.authentik = {
      enable = true;
      environmentFile = config.sops.templates."authentik-env".path;
      settings = {
        disable_startup_analytics = true;
        avatars = "initials";
      };

      nginx = {
        enable = true;
        enableACME = true;
        host = "sso.xanderio.de";
      };
    };
  };
}
