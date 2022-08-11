{ pkgs, ... }: {
  programs.starship = {
    enable = true;
    settings = {
      command_timeout = 100;
      add_newline = false;
      directory = {
        truncation_length = 5;
        truncation_symbol = "…/";
      };
      status = {
        disabled = false;
        symbol = "🚨";
      };
      git_status.conflicted = "🤯";
    };
  };
}
