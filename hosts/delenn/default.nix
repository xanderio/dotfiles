{
  imports = [
    ./configuration.nix
    ./matrix.nix
    ../../modules/server
    ./authentik.nix
  ];
  networking.hostName = "delenn";

  deployment.targetHost = "delenn.xanderio.de";

  services.journald.extraConfig = ''
    SystemMaxUse = 1G
  '';
}
