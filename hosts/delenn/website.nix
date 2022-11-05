{ inputs, ... }: {
  services.nginx.virtualHosts = {
    "xanderio.de" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        root = "${inputs.website.packages.x86_64-linux.website}";
      };
    };
  };
}
