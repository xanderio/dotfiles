{ pkgs, ... }:
{
  programs = {
    taskwarrior = {
      enable = true;
      colorTheme = "dark-256";
      extraConfig = ''
        include ~/.config/task/localrc
      '';
    };
  };

  systemd.user = {
    services.task-sync = {
      Unit = {
        Description = "sync taskwarrior";
      };
      Service = {
        ExecStart = "${pkgs.taskwarrior}/bin/task sync";
      };
    };

    timers.task-sync = {
      Unit = {
        Description = "sync taskwarrior";
      };

      Install.WantedBy = [ "timers.target" ];

      Timer = {
        Unit = "task-sync.service";
        OnActiveSec = "10m";
      };
    };
  };

  home = {
    file.".task/hooks/on-modify.timewarrior" = {
      executable = true;
      source = pkgs.timewarrior-hook;
    };
    packages = with pkgs; [
      timewarrior
      taskwarrior-tui
    ];
  };
}
