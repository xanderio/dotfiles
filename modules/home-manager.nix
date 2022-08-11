{ config
, pkgs
, libs
, ...
}: {
  programs.home-manager.enable = true;
  home.sessionVariables = {
    PAGER = "less";
    LESS = "-qR";
  };
}
