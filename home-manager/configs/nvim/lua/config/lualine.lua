local gps = require("nvim-gps")
require('lualine').setup({ 
  options = { 
    theme = 'dracula-nvim',
    component_separators = '|',
    globalstatus = true
  },
  extensions = { 'fugitive' },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { {'b:gitsigns_head', icon = ''}, { 'diff', color_added = '#50fa7b' } },
    lualine_c = { {'filename', file_status = true }, { 'diagnostics', sources = {'nvim_diagnostic'}}, { gps.get_location, cond = gps.is_available }}, 
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress', require'lsp'.status },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_c = { "filename" },
    lualine_x = { "location" }
  }
})
