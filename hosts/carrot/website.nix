{ inputs, pkgs, ... }: {
  config = {
    services.nginx = {
      enable = true;
      virtualHosts = {
        "xanderio.de" = {
          enableACME = true;
          forceSSL = true;
          locations."/" = {
            root = "${inputs.website.packages.${pkgs.system}.website}";
          };
        };
      };
    };
  };
}
