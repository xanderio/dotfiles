{ lib
, config
, ...
}: {
  services.prometheus.exporters.wireguard =
    lib.mkIf config.networking.wireguard.enable
      {
        enable = true;
      };
}
