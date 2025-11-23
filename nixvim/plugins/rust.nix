{ pkgs, ... }:
{
  plugins = {
    rustaceanvim = {
      enable = true;
      settings = {
        # Build the code for LSP on a different path to avoid blocking
        server.default_settings.rust-analyzer.cargo.targetDir = "target/lsp";
      };
    };

    dap-lldb = {
      enable = true;
      settings.codelldb_path = "${pkgs.vscode-extensions.vadimcn.vscode-lldb.adapter}/bin/codelldb";
    };
  };

  # autoCmd = [{
  #   desc = "Rust-specific keymaps for rustaceanvim";
  #   command = "lua vim.keymap.set('n', '<C-.>', function() vim.cmd.RustLsp('codeAction') end, { silent = true, buffer = true })";
  #   event = "FileType";
  #   pattern = "rust";
  # }];

  extraPackagesAfter = [ pkgs.vscode-extensions.vadimcn.vscode-lldb.adapter ];
}
