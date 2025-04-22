{
  # Highlight, edit, and navigate code
  # https://nix-community.github.io/nixvim/plugins/treesitter/index.html
  plugins.treesitter = {
    enable = true;

    settings = {
      highlight = {
        enable = true;
      };
      indent = {
        enable = true;
      };
    };
  };

  dependencies = {
    tree-sitter.enable = false;
    gcc.enable = false;
    nodejs.enable = false;
  };
}
