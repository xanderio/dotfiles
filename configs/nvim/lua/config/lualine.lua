require('lualine').setup({ 
  options = { 
    theme = 'dracula-nvim',
    component_separators = '|'
  },
  extensions = { 'fugitive' },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', { 'diff', color_added = '#50fa7b' } },
    lualine_c = { {'filename', file_status = true }, { 'diagnostics', sources = {'nvim_diagnostic'}}}, 
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress', require'lsp'.status },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_c = { "filename" },
    lualine_x = { "location" }
  }
})
