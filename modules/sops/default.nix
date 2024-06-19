{ lib, config, ... }:
let
  cfg = config.x.sops;
in
{
  options.x.sops = with lib; {
    secrets = mkOption {
      type = types.attrs;
      default = { };
    };
  };
  config = {
    sops.secrets = lib.mapAttrs (
      name: value:
      let
        name_split = lib.splitString "/" name;
      in
      {
        sopsFile = ../../secrets/${builtins.elemAt name_split 0}/${builtins.elemAt name_split 1}.yaml;
      }
      // value
    ) cfg.secrets;
  };
}
