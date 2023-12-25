{
  imports = [
    ./configuration.nix
    ./matrix.nix
    ../../modules/server
    ./authentik.nix
  ];
  networking.hostName = "delenn";

  deployment.targetHost = "delenn.xanderio.de";

  services.ntfy = {
    enable = true;
    domain = "ntfy.xanderio.de";
    settings = {
      auth-default-access = "deny-all";
    };
  };

  services.journald.extraConfig = ''
    SystemMaxUse = 1G
  '';
}
