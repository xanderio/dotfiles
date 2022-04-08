{ pkgs, ... }:
{
  programs = {
    taskwarrior = {
      enable = true;
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
