{ pkgs
, ...
}: {
  imports = [
    ./configuration.nix
    ./matrix.nix
  ];
  networking.hostName = "delenn";

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
