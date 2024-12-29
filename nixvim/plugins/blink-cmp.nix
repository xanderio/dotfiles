{
  plugins.lsp.capabilities = # lua
    ''
      capabilities = require('blink.cmp').get_lsp_capabilities()
    '';

  plugins.blink-cmp = {
    enable = true;
    settings = {
      keymap = {
        preset = "enter";
        "<Tab>" = [
          "select_next"
          "fallback"
        ];
        "<S-Tab>" = [
          "select_prev"
          "fallback"
        ];
      };
      completion = {
        list.selection = "auto_insert";
        # Shows after typing a trigger character, defined by the sources
        trigger.show_on_trigger_character = true;
      };
      sources = {
        default = [
          "lsp"
          "path"
          "snippets"
          "buffer"
        ];
        providers = {
          buffer = {
            max_items = 5;
            min_keyword_length = 3;
          };
        };
      };
    };
  };
}
