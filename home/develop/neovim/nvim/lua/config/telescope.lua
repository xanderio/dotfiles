vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>lua require("telescope.builtin").find_files()<CR>', {noremap=true, silent=true})
