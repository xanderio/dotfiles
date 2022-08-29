{ pkgs
, ...
}: {
  imports = [
    ./configuration.nix
  ];
  networking.hostName = "delenn";

  services.ntfy = {
    enable = true;
    domain = "ntfy.xanderio.de";
    settings = {
      auth-default-access = "deny-all";
    };
  };
}
