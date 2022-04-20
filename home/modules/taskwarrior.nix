{ pkgs, ... }: {
  programs = {
    taskwarrior = {
      enable = true;
      #colorTheme = "dark-256";
      config = {
        color = {
          error = "white on red";
        };
      };
    };
  };

  services.taskwarrior-sync = {
    enable = true;
  };

  systemd.user = {
    services =
      {
        bugwarrior-pull = {
          Unit = {
            Description = "Bugwarrior pull";
          };
          Service = {
            CPUSchedulingPolicy = "idle";
            IOSchedulingClass = "idle";
            ExecStart = "${pkgs.python39Packages.bugwarrior}/bin/bugwarrior-pull";
          };
        };
      };

    timers = {
      bugwarrior-pull = {
        Unit = {
          Description = "Bugwarrior pull";
        };

        Install.WantedBy = [ "timers.target" ];

        Timer = {
          Unit = "bugwarrior-pull.service";
          OnCalendar = "*:0/5";
        };
      };
    };
  };

  xdg.configFile."bugwarrior/bugwarriorrc".source = ../configs/bugwarriorrc;
  home = {
    file.".local/share/task/hooks/on-modify.timewarrior" = {
      executable = true;
      source = pkgs.timewarrior-hook;
    };
    packages = with pkgs; [
      timewarrior
      taskwarrior-tui
      python39Packages.bugwarrior
    ];
  };
}
