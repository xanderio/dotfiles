{...}: {
  services.nginx.virtualHosts = {
    "xanderio.de" = {
      enableACME = true;
      forceSSL = true;
      locations = let
      in {
        "/" = {
          root = "/var/website";
        };
      };
    };
  };
}
