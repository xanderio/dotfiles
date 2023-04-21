{
  services.nginx.virtualHosts."cloud.xanderio.de" = {
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://[fd7a:115c:a1e0:ab12:4843:cd96:626e:4b10]";
    };
  };
}
