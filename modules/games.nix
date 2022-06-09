{ config
, pkgs
, lib
, ...
}:
with lib; let
  cfg = config.xanderio;
in
{
  options.xanderio.minecraft.enable = mkEnableOption "Minecraft";

  config = {
    home.packages =
      [ pkgs.ferium pkgs.polymc ]
      ++ optional cfg.minecraft.enable pkgs.minecraft;
  };
}
