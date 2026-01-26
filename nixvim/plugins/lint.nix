{ pkgs, ... }:
{

  extraPackages = with pkgs; [
    deadnix
    markdownlint-cli
    djlint
  ];

  # Linting
  # https://nix-community.github.io/nixvim/plugins/lint/index.html
  plugins.lint = {
    enable = true;

    # NOTE: Enabling these will cause errors unless these tools are installed
    lintersByFt = {
      nix = [ "deadnix" ];
      markdown = [
        "markdownlint"
        #vale
      ];
      "htmldjango" = [ "djlint" ];
      "jinja" = [ "djlint" ];
      #clojure = ["clj-kondo"];
      #dockerfile = ["hadolint"];
      #inko = ["inko"];
      #janet = ["janet"];
      #json = ["jsonlint"];
      #rst = ["vale"];
      #ruby = ["ruby"];
      #terraform = ["tflint"];
      #text = ["vale"];
    };

    # Create autocommand which carries out the actual linting
    # on the specified events.
    autoCmd = {
      callback.__raw = ''
        function()
          require('lint').try_lint()
        end
      '';
      group = "lint";
      event = [
        "BufEnter"
        "BufWritePost"
        "InsertLeave"
      ];
    };
  };

  # https://nix-community.github.io/nixvim/NeovimOptions/autoGroups/index.html
  autoGroups = {
    lint = {
      clear = true;
    };
  };
}
