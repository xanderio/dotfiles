{
  plugins.neotest = {
    enable = true;
    adapters = {
      elixir.enable = true;
      rust.enable = true;
      python.enable = true;
    };
    luaConfig.post = # lua
      ''
        local group = vim.api.nvim_create_augroup("NeotestConfig", {})
        for _, ft in ipairs({ "output", "attach", "summary" }) do
          vim.api.nvim_create_autocmd("FileType", {
            pattern = "neotest-" .. ft,
            group = group,
            callback = function(opts)
              vim.keymap.set("n", "q", function()
                pcall(vim.api.nvim_win_close, 0, true)
              end, {
                buffer = opts.buf,
              })
            end,
          })
        end
      '';
  };
  keymaps = [
    {
      mode = "n";
      key = "<leader>tr";
      action.__raw = # lua
        ''
          require("neotest").run.run
        '';
    }
    {
      mode = "n";
      key = "<leader>tf";
      action.__raw = # lua
        ''
          function()
            require("neotest").run.run(vim.fn.expand("%"))
          end
        '';
    }
    {
      mode = "n";
      key = "<leader>tt";
      action.__raw = # lua
        ''
          require("neotest").summary.toggle
        '';
    }
    {
      mode = "n";
      key = "<leader>to";
      action.__raw = # lua
        ''
          require("neotest").output.open
        '';
    }
  ];
}
