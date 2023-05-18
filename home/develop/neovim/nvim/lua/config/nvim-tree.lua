require('nvim-tree').setup()

vim.keymap.set('n', '<C-n>', function()
  require('nvim-tree.api').tree.find_file({ 
    buf = vim.fn.bufnr(), 
    open = true, 
    focus = true
  })
end
)


local function open_nvim_tree(data)
  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end

  -- change to the directory
  vim.cmd.cd(data.file)

  -- open the tree
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
