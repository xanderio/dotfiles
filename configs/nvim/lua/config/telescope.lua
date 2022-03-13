local function map(lhs, rhs)
  vim.api.nvim_set_keymap('n', '<leader>' .. lhs, rhs, {noremap=true, silent=true})
end

vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>lua require("telescope.builtin").find_files()<CR>', {noremap=true, silent=true})
map('pb', '<cmd>lua require("telescope.builtin").buffers()<cr>')
map('pg', '<cmd>lua require("telescope.builtin").live_grep()<cr>')

require('telescope').setup({
  extensions = {
    gitmoji = {
      action = function(entry)
        local emoji = entry.value or ""
        vim.api.nvim_put({ emoji }, "c", true, true)
      end
    }
  }
})
require('telescope').load_extension('gitmoji')
