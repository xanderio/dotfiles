require('nvim-treesitter.configs').setup({
  ensure_installed = 'maintained',
  highlight = { enable = true },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
  indent = { enable = false }
})

vim.api.nvim_set_keymap('o', 'm', '<cmd>lua require("tsht").nodes()<CR>', {silent=true})
vim.api.nvim_set_keymap('v', 'm', '<cmd>lua require("tsht").nodes()<CR>', {noremap=true, silent=true})
