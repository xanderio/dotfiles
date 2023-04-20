local neotest = require("neotest")

neotest.setup({
  adapters = {
    require("neotest-rust"),
    require("neotest-elixir")
  },
})

vim.keymap.set('n', '<leader>tr', neotest.run.run)
vim.keymap.set('n', '<leader>tf', function() neotest.run.run(vim.fn.expand("%")) end)
vim.keymap.set('n', '<leader>tt', neotest.summary.toggle)
vim.keymap.set('n', '<leader>to', neotest.output.open)
