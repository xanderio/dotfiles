{
  imports = [
    ./common.nix

    # Plugins
    ./plugins/blink-cmp.nix
    ./plugins/conform.nix
    ./plugins/dap.nix
    ./plugins/lint.nix
    ./plugins/lsp.nix
    ./plugins/mini.nix
    ./plugins/neo-tree.nix
    ./plugins/nvim-snippets.nix
    ./plugins/conform.nix
    ./plugins/treesitter.nix
  ];

  performance.byteCompileLua = {
    enable = false;
    nvimRuntime = true;
    plugins = true;
  };

  plugins = {
    web-devicons = {
      enable = true;
    };
  };
}
