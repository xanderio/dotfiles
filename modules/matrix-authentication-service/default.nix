{
  config,
  lib,
  pkgs,
  utils,
  ...
}:

let
  cfg = config.services.matrix-authentication-service;

  inherit (lib)
    getExe
    mkEnableOption
    mkOption
    mkPackageOption
    mkIf
    types
    ;

  inherit (utils)
    escapeSystemdExecArgs
    ;

  format = pkgs.formats.yaml { };
  configFile = format.generate "mas-config.yaml" cfg.settings;
in
{
  options.services.matrix-authentication-service = {
    enable = mkEnableOption "the Matrix Authentication Service (MAS)";

    package = mkPackageOption pkgs "matrix-authentication-service" { };

    extraArgs = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = ''
        Additional arguments passed to the mas-cli server process.
      '';
    };

    settings = mkOption {
      default = { };
      description = ''
        Primary configuration file as a Nix attribute set.

        See the [configuration reference](https://element-hq.github.io/matrix-authentication-service/reference/configuration.html) for possible options.
      '';
      type = types.submodule {
        freeformType = format.type;
        options = {
        };
      };
    };

    extraConfigFiles = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = ''
        Extra configuration files passed to the mas-cli server process.

        This option can be used to safely pass configuration containing secrets.
      '';
    };
  };

  config = mkIf cfg.enable {
    systemd.services.matrix-authentication-service = {
      description = "Matrix Authentication Service";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        DynamicUser = true;
        User = "matrix-authentication-service";
        Group = "matrix-authentication-service";

        RuntimeDirectory = "matrix-authentication-service";
        RuntimeDirectoryMode = "0777";
        Restart = "on-failure";
        ExecPreStart = escapeSystemdExecArgs (
          [
            (getExe cfg.package)
            "config"
            "sync"
            "--prune"
            "--config"
            configFile
          ]
          ++ (lib.concatMap (path: [
            "--config"
            path
          ]) cfg.extraConfigFiles)
        );

        ExecStart = escapeSystemdExecArgs (
          [
            (getExe cfg.package)
            "server"
            "--config"
            configFile
          ]
          ++ (lib.concatMap (path: [
            "--config"
            path
          ]) cfg.extraConfigFiles)
          ++ cfg.extraArgs
        );
      };
    };
    environment.systemPackages = [ cfg.package ];
  };
}
