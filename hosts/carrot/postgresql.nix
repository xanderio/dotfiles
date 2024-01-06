{ pkgs, lib, ... }: {
  services.postgresql = {
    enable = true;
    package = lib.mkForce pkgs.postgresql_15;
  };
}
