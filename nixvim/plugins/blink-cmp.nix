{
  plugins.lsp.capabilities = # lua
    ''
      capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
    '';

  plugins.mini = {
    enable = true;
    modules.icons = { };
  };

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
        list.selection = {
          preselect.__raw = ''
            function(ctx) 
              return ctx.mode ~= 'cmdline' 
            end
          '';
          auto_insert.__raw = ''
            function(ctx) 
              return ctx.mode ~= 'cmdline' 
            end
          '';
        };
        # Shows after typing a trigger character, defined by the sources
        trigger.show_on_trigger_character = true;
        menu.draw = {
          components.label = {
            ellipsis = false;
            text.__raw = ''
              function(ctx)
                return ctx.label
              end
            '';
          };
          components.kind_icon = {
            ellipsis = false;
            text.__raw = ''
              function(ctx)
                local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                return kind_icon
              end
            '';
            highlight.__raw = ''
              function(ctx)
                local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                return hl
              end
            '';
          };
        };
      };
      signature.enabled = true;
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
