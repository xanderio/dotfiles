{ config, pkgs, ... }:
{
  systemd.services.drone-runner-docker = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      EnvironmentFile = [
        config.age.secrets.drone.path
      ];
      Environment = [

        "DRONE_RUNNER_CAPACITY=10"
        "DRONE_RUNNER_ENVIRON=${builtins.concatStringsSep "," [
          "NIX_REMOTE:daemon"
        ]}"
        "DRONE_RUNNER_VOLUMES=${builtins.concatStringsSep "," [
          "/nix/var/nix/daemon-socket/socket"
          "/run/nscd/socket"
          "/var/lib/drone"
          "${config.environment.etc."ssl/certs/ca-certificates.crt".source}:/etc/ssl/certs/ca-certificates.crt:ro"
          "/nix/:/nix/:ro"
        ]}"
        "CLIENT_DRONE_RPC_HOST=127.0.0.1:3030"
      ];
      ExecStart = "${pkgs.drone-runner-docker}/bin/drone-runner-docker";
      User = "drone-runner-docker";
      Group = "drone-runner-docker";
    };
  };

  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };

  users.users.drone-runner-docker = {
    isSystemUser = true;
    extraGroups = [ "docker" ];
    group = "drone-runner-docker";
  };

  users.groups.drone-runner-docker = { };
}
