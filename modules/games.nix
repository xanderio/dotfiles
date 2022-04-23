{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.xanderio;
in {
  options.xanderio.minecraft.enable = mkEnableOption "Minecraft";

  config = {
    home.packages =
      optional cfg.minecraft.enable pkgs.minecraft;
  };
}
