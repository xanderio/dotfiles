{ pkgs
, config
, ...
}:
let
  woodpeckeragent = config.users.users.woodpeckeragent.name;
in
{
  systemd.services.woodpecker-agent = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      EnvironmentFile = [
        config.age.secrets.woodpecker.path
      ];
      ExecStart = "${pkgs.woodpecker-agent}/bin/woodpecker-agent";
      User = woodpeckeragent;
      Group = woodpeckeragent;
    };
  };

  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };

  users.users.woodpeckeragent = {
    isSystemUser = true;
    createHome = true;
    extraGroups = [ "docker" ];
    group = woodpeckeragent;
  };

  users.groups.woodpeckeragent = { };
}
