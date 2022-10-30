local function map(lhs, rhs)
  vim.api.nvim_set_keymap('n', '<leader>' .. lhs, rhs, {noremap=true, silent=true})
end

vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>lua require("telescope.builtin").find_files()<CR>', {noremap=true, silent=true})
map('pb', '<cmd>lua require("telescope.builtin").buffers()<cr>')
map('pg', '<cmd>lua require("telescope.builtin").live_grep()<cr>')
