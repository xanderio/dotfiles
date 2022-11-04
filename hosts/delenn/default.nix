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
  services.borgbackup.jobs.backup.paths = [ "/mnt/paperless" "/mnt/nextcloud" ];
}
