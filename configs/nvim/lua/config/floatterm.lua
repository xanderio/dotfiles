local map = vim.api.nvim_set_keymap
local opts = { silent = true }

map('n', '<A-i>', '<cmd>FloatermToggle<CR>', opts)
map('t', '<A-i>', '<C-\\><C-n><cmd>FloatermToggle<CR>', opts)
