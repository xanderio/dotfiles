if pcall(require, 'impatient') then
  require('impatient')
end

vim.g.do_filetype_lua = 1

local cmd, g, b, w = vim.cmd, vim.g, vim.b, vim.w
local function map(lhs, rhs)
    vim.api.nvim_set_keymap('n', '<leader>' .. lhs, rhs, {noremap=true, silent=true})
end

vim.g.mapleader = " "

require('plugins')
require('config.notify')
require("config.lualine")
require('config.telescope')
require('config.gitsigns')
require('config.cmp')
require('config.colorschema')
require('config.floatterm')
require('config.treesitter')
require("nvim-gps").setup()
require('config.dap')
require('dapui').setup()
require('config/rust-tools')
require('fidget').setup({
  text = {
    spinner = "dots_negative",
  },
  window = {
    blend = 0,
  },
})
require('spellsitter').setup()
require("docs-view").setup {
      position = "right",
      width = 60,
    }

vim.g.code_action_menu_show_diff = false

local lsp_status = require('lsp-status')
lsp_status.register_progress() 
lsp_status.config({
  diagnostics = false,
  current_function = false,
  status_symbol = ''
}) 

local neogit = require('neogit')
neogit.setup({})

require("indent_blankline").setup {
  show_current_context = true,
  show_current_context_start = false,
}

vim.api.nvim_set_keymap("x", "<leader>a", "<Plug>(EasyAlign)", {})
vim.api.nvim_set_keymap("n", "<leader>a", "<Plug>(EasyAlign)", {})

require('crates').setup()

-- luasnip
vim.api.nvim_set_keymap("i", "<C-E>", "<Plug>luasnip-next-choice", {})
vim.api.nvim_set_keymap("s", "<C-E>", "<Plug>luasnip-next-choice", {})

local null_ls = require('null-ls')
null_ls.setup({
  sources = {
    -- js,ts,etc.
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.diagnostics.eslint_d,

    -- shell
    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.formatting.fish_indent,
    null_ls.builtins.diagnostics.shellcheck,

    -- Nix
    null_ls.builtins.code_actions.statix,
    null_ls.builtins.formatting.alejandra,

    -- python
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.diagnostics.pylama,

    -- ansible
    null_ls.builtins.diagnostics.ansiblelint,

    -- docker 
    null_ls.builtins.diagnostics.hadolint,

    -- gitlint
    null_ls.builtins.diagnostics.gitlint,
  },
  on_attach = require('lsp').on_attach
})

local servers = { 
  'bashls',
  'cssls',
  'dartls',
  'dockerls',
  'taplo',
  'terraform_lsp',
  'yamlls',
};
for _, lsp in ipairs(servers) do
  require('lspconfig')[lsp].setup({
    capabilities = require('lsp').capabilities(),
    on_attach = require('lsp').on_attach,
  })
end

require('lspconfig').rnix.setup({
  capabilities = require('lsp').capabilities(),
  on_attach = function(client, bufnr)
    require('lsp').on_attach(client, bufnr)
  end,
})
require('lspconfig').pyright.setup({
  capabilities = require('lsp').capabilities(),
  on_attach = require('lsp').on_attach,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        typeCheckingMode = "basic",
        useLibraryCodeForTypes = true,
      },
    },
  }
})

require'lspconfig'.tsserver.setup({
  init_options = require("nvim-lsp-ts-utils").init_options,
  capabilities = require('lsp').capabilities(),
  on_attach = function(client, bufnr)
    local ts_utils = require("nvim-lsp-ts-utils")
    ts_utils.setup({})
    ts_utils.setup_client(client)

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local opts = { noremap=true, silent=true }
    buf_set_keymap("n", "gs", ":TSLspOrganize<CR>", opts)
    buf_set_keymap("n", "gi", ":TSLspRenameFile<CR>", opts)
    buf_set_keymap("n", "go", ":TSLspImportAll<CR>", opts)

    require('lsp').on_attach(client, bufnr)
  end,
})

-- generate help tags for all plugins
cmd 'silent! helptags ALL'
cmd 'unmap Y'

-- Spelling
-- Correct current word
vim.keymap.set('n', 'z=',
  function()
    require("telescope.builtin").spell_suggest()
  end
) 
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

