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

  service = config.systemd.services.matrix-authentication-service;
  mas-cli-wrapper = pkgs.writeScriptBin "mas-cli" 
    # bash
    ''
    #! ${pkgs.runtimeShell}
    exec systemd-run \
      -u matrix-authentication-service-cli.service \
      -p User=${service.serviceConfig.User} \
      -p Group=${service.serviceConfig.Group} \
      ${ lib.concatStringsSep " " (map (cred: "-p LoadCredential=${cred}") service.serviceConfig.LoadCredential)} \
      ${ lib.concatStringsSep " " (map (env: "-p Environment=${lib.replaceStrings ["%d"] ["/run/credentials/matrix-authentication-service-cli.service"] env}") service.serviceConfig.Environment)} \
      -q -t -P -G --wait --service-type=exec \
      ${lib.getExe cfg.package} "$@"
  '';
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
    systemd.services.matrix-authentication-service =
      {
        description = "Matrix Authentication Service";
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          DynamicUser = true;
          User = "matrix-authentication-service";
          Group = "matrix-authentication-service";
          Environment = [
            "MAS_CONFIG=${(lib.concatStringsSep ":" ([configFile] ++ (
              lib.imap (i: _: "%d/extraConfig-${toString i}.yaml") cfg.extraConfigFiles
            )))}"
          ];

          LoadCredential = lib.imap (i: file: "extraConfig-${toString i}.yaml:${file}") cfg.extraConfigFiles;

          RuntimeDirectory = "matrix-authentication-service";
          RuntimeDirectoryMode = "0777";
          Restart = "on-failure";
          ExecPreStart =
            escapeSystemdExecArgs [
              (getExe cfg.package)
              "config"
              "sync"
              "--prune"
            ];

          ExecStart =
            escapeSystemdExecArgs (
              [
                (getExe cfg.package)
                "server"
              ]
              ++ cfg.extraArgs
            );
        };
      };
    environment.systemPackages = [ mas-cli-wrapper ];
  };
}
