{ pkgs, ... }:
{
  # Neo-tree is a Neovim plugin to browse the file system
  # https://nix-community.github.io/nixvim/plugins/neo-tree/index.html?highlight=neo-tree#pluginsneo-treepackage
  plugins.neo-tree = {
    enable = true;

    extraSources = [
      "document_symbols"
    ];

    sourceSelector = {
      winbar = true;
      sources = [
        { source = "filesystem"; }
        { source = "document_symbols"; }
        { source = "buffers"; }
        { source = "git_status"; }
      ];
    };

    filesystem = {
      followCurrentFile = {
        enabled = true;
        leaveDirsOpen = true;
      };
      useLibuvFileWatcher = true;
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
