{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      darcs
    ];
    sessionVariables = {
      DARCS_ALWAYS_COLOR = "1";
      DARCS_ALTERNATIVE_COLOR = "1";
      DARCS_DO_COLOR_LINES = "1";
    };
  };
}
