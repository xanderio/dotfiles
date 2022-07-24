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
      [ pkgs.polymc-qt6 ]
      ++ optional cfg.minecraft.enable pkgs.minecraft;
  };
}
