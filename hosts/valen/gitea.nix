{ pkgs
, config
, ...
}: {
  services = {
    gitea = rec {
      enable = true;
      domain = "git.xanderio.de";
      rootUrl = "https://${domain}";
      httpPort = 3050;
      lfs.enable = true;
      settings.service = {
        DISABLE_REGISTRATION = true;
        COOKIE_SECURE = true;
      };
    };
    openssh.extraConfig = ''
      AcceptEnv GIT_PROTOCOL
    '';
    nginx = {
      enable = true;
      virtualHosts.${config.services.gitea.domain} = {
        enableACME = true;
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://localhost:${builtins.toString config.services.gitea.httpPort}";
        };
      };
    };
  };
}
