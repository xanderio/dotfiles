{...}: {
  programs.ssh = {
    enable = true;

    includes = ["~/.ssh/private_ssh_config"];

    matchBlocks = {
      all = {
        extraOptions = {
          SetEnv = "TERM=xterm-256color";
        };
      };
    };
  };
}
