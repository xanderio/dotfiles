{
  plugins.lsp.capabilities = # lua
    ''
      capabilities = require('blink.cmp').get_lsp_capabilities()
    '';

  plugins.blink-cmp = {
    enable = true;
    settings = {
      keymap = {
        preset = "super-tab";
      };
    };
  };
}
