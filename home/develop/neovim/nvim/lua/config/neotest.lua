local neotest = require("neotest")

neotest.setup({
  adapters = {
    require("neotest-rust"),
    require("neotest-elixir")
  },
  quickfix = {
    open = false
  },
})

vim.keymap.set('n', '<leader>tr', neotest.run.run)
vim.keymap.set('n', '<leader>tf', function() neotest.run.run(vim.fn.expand("%")) end)
vim.keymap.set('n', '<leader>tt', neotest.summary.toggle)
vim.keymap.set('n', '<leader>to', neotest.output.open)

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
