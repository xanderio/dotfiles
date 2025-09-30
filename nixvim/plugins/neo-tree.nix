{ pkgs, ... }:
{
  # Neo-tree is a Neovim plugin to browse the file system
  # https://nix-community.github.io/nixvim/plugins/neo-tree/index.html?highlight=neo-tree#pluginsneo-treepackage
  plugins.neo-tree = {
    enable = true;

    filesystem = {
      followCurrentFile.enabled = true;
      use_libuv_file_watcher = true;
      window = {
        mappings = {
          "\\" = "close_window";
        };
      };
    };
  };

  extraPlugins = with pkgs.vimPlugins; [
    nvim-window-picker
  ];

  # https://nix-community.github.io/nixvim/keymaps/index.html
  keymaps = [
    {
      key = "\\";
      action = "<cmd>Neotree reveal<cr>";
      options = {
        desc = "NeoTree reveal";
      };
    }
  ];
}
