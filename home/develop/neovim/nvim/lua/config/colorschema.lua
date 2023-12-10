local dracula = require("dracula")
local colors = dracula.colors()
dracula.setup({
  transparent_bg = true,
  overrides = {
    FidgetTitle = { fg = colors.green, bg = colors.bg },
    FidgetTask = { fg = colors.purple, bg = colors.bg },
    ['@punctuation'] = {fg = colors.fg},

    NeogitDiffAdd = { fg = colors.green, bg = colors.bg },
    NeogitDiffDelete = { fg = colors.red, bg = colors.bg },
    NeogitDiffContext = { fg = colors.fg, bg = colors.bg },

    NeogitDiffAddHighlight = { fg = colors.green, bg = colors.bg },
    NeogitDiffDeleteHighlight = { fg = colors.red, bg = colors.bg },
    NeogitDiffContextHighlight = { fg = colors.fg, bg = colors.bg },

    NeogitCursorLine = { bg = colors.selection },
  },
})
vim.cmd 'colorscheme dracula'
