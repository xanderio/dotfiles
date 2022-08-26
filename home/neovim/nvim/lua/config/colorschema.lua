local dracula = require("dracula")
local colors = dracula.colors()
dracula.setup({
  transparent_bg = true,
  overrides = {
    FidgetTitle = { fg = colors.green, bg = colors.bg },
    FidgetTask = { fg = colors.purple, bg = colors.bg },
  },
})
vim.cmd 'colorscheme dracula'
