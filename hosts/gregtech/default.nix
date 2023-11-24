{ inputs, lib, pkgs, config, ... }: {
  imports = [
    inputs.mms.module
    ../../modules/server
    ./hardware-configuration.nix
    ./networking.nix
  ];
  networking.hostName = "gregtech";

  deployment.targetHost = "gregtech.bitflip.jetzt";

  services.journald.extraConfig = ''
    SystemMaxUse = 1G
  '';

  environment.systemPackages = [
    (pkgs.writeShellApplication {
      name = "rcon";
      runtimeInputs = with pkgs; [ mcrcon ];
      text =
        let
          inherit (config.services.modded-minecraft-servers.instances.gtnh) serverConfig;
        in
        ''
          mcrcon -P ${toString serverConfig.rcon-port} -p ${serverConfig.rcon-password}
        '';
    })
  ];

  services.modded-minecraft-servers = {
    eula = true;

    instances.gtnh = {
      enable = true;

      rsyncSSHKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJDvsq3ecdR4xigCpOQVfmWZYY74KnNJIJ5Fo0FsZMGW"
      ];

      jvmMaxAllocation = "6G";
      jvmInitialAllocation = "6G";
      jvmPackage = pkgs.temurin-bin-20;

      jvmOpts = lib.concatStringsSep " " [
        "-XX:+UseG1GC"
        "-XX:+ParallelRefProcEnabled"
        "-XX:MaxGCPauseMillis=200"
        "-XX:+UnlockExperimentalVMOptions"
        "-XX:+DisableExplicitGC"
        "-XX:+AlwaysPreTouch"
        "-XX:G1NewSizePercent=40"
        "-XX:G1MaxNewSizePercent=50"
        "-XX:G1HeapRegionSize=16M"
        "-XX:G1ReservePercent=15"
        "-XX:G1HeapWastePercent=5"
        "-XX:G1MixedGCCountTarget=4"
        "-XX:InitiatingHeapOccupancyPercent=20"
        "-XX:G1MixedGCLiveThresholdPercent=90"
        "-XX:G1RSetUpdatingPauseTimePercent=5"
        "-XX:SurvivorRatio=32"
        "-XX:+PerfDisableSharedMem"
        "-XX:MaxTenuringThreshold=1"
      ];


      serverConfig = {
        server-port = 25565;
        motd = "Welcome to Greg Tech New Horizons";
        white-list = true;
        spawn-protection = 0;

        level-type = "rwg";
        level-seed = "1202743790";

        max-tick-time = 5 * 60 * 1000;

        allow-flight = true;
        extra-options = {
          "announce-player-achievements" = true;
        };
      };
    };
  };
}
