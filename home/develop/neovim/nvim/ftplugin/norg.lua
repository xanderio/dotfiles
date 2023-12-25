vim.bo.expandtab = true
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.textwidth = 80
require('cmp').setup.buffer { 
  sources = { 
    { name = 'neorg' },
    { name = 'calc' },
    { name = 'path' },
    { name = 'buffer' }
  }}
