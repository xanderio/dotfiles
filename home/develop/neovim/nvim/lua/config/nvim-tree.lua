require('nvim-tree').setup()
vim.keymap.set('n', '<leader>tt' , require('nvim-tree.api').tree.toggle)
vim.keymap.set('n', '<leader>tf' , require('nvim-tree.api').tree.focus)
