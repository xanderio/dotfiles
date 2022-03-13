if pcall(require, 'impatient') then
  require('impatient')
end
local cmd, g, b, w = vim.cmd, vim.g, vim.b, vim.w
local function map(lhs, rhs)
    vim.api.nvim_set_keymap('n', '<leader>' .. lhs, rhs, {noremap=true, silent=true})
end

vim.g.mapleader = " "

require('plugins')

-- generate help tags for all plugins
cmd 'silent! helptags ALL'
cmd 'unmap Y'

-- Spelling
-- Correct current word
vim.api.nvim_set_keymap('n', 'z=', ':lua require("telescope.builtin").spell_suggest()<cr>', {silent=true}) 
map('sl', ':lua cyclelang()<cr>') --Change spelling language
do
    local i = 1
    local langs = {'', 'en', 'de'}
    function cyclelang()
        i = (i % #langs) + 1     -- update index
        b.spelllang = langs[i]   -- change spelllang
        w.spell = langs[i] ~= '' -- if empty then nospell
    end
end

-- Hightlight selection on yank
cmd 'au TextYankPost * silent! lua vim.highlight.on_yank()'

map('rc', '<cmd> e ~/.config/nvim <cr>')  -- open config directory

