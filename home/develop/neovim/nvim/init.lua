if pcall(require, 'impatient') then
  require('impatient')
end

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.do_filetype_lua = 1

local cmd, g, b, w = vim.cmd, vim.g, vim.b, vim.w
local function map(lhs, rhs)
    vim.api.nvim_set_keymap('n', '<leader>' .. lhs, rhs, {noremap=true, silent=true})
end

vim.g.mapleader = " "
vim.g.maplocalleader = ","

require('config.notify')
require("config.lualine")
require('config.telescope')
require('config.gitsigns')
require('config.cmp')
require('config.colorschema')
require('config.floatterm')
require('config.treesitter')
require('config.hydra')
require('config.dap')
require('dapui').setup()
require('config/rust-tools')
require('config.neotest')
require('fidget').setup({
  notification = {
    window = {
      winblend = 0
    }
  }
})
require('config.nvim-tree')

vim.g.code_action_menu_show_diff = false

local lsp_status = require('lsp-status')
lsp_status.register_progress() 
lsp_status.config({
  diagnostics = false,
  current_function = false,
  status_symbol = ''
}) 

local neogit = require('neogit')
neogit.setup({
  integrations = {
    telescope = true,
    diffview = true
  },
})

require('Comment').setup()

require("ibl").setup {
  scope = {
    show_start = false
  }
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
    null_ls.builtins.formatting.prettier,

    -- shell
    null_ls.builtins.formatting.fish_indent,

    -- Nix
    null_ls.builtins.code_actions.statix,

    -- ansible
    null_ls.builtins.diagnostics.ansiblelint,

    -- gitlint
    null_ls.builtins.diagnostics.gitlint,
  },
  on_attach = require('lsp').on_attach
})

-- To appropriately highlight codefences returned from denols
vim.g.markdown_fenced_languages = {
  "ts=typescript"
}

local servers = { 
  'bashls',
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

require('lspconfig').cssls.setup({
  cmd = { "css-languageserver", "--stdio" }, 
  capabilities = require('lsp').capabilities(),
  on_attach = function(client, bufnr)
    require('lsp').on_attach(client, bufnr)
  end,
})

require('lspconfig').emmet_ls.setup({
  capabilities = require('lsp').capabilities(),
  filetypes = { "astro", "css", "eruby", "html", "htmldjango", "javascriptreact", "less", "pug", "sass", "scss", "svelte", "typescriptreact", "vue", "heex" },
  on_attach = function(client, bufnr)
    require('lsp').on_attach(client, bufnr)
  end,
})

require('lspconfig').tsserver.setup({
  capabilities = require('lsp').capabilities(),
  on_attach = function(client, bufnr)
    require('lsp').on_attach(client, bufnr)
  end,
})

require('lspconfig').volar.setup({
  capabilities = require('lsp').capabilities(),
  on_attach = function(client, bufnr)
    require('lsp').on_attach(client, bufnr)
  end,
  init_options = {
    vue = {
      hybridMode = false,
    },
  },
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
})

require('lspconfig').pylsp.setup({
  capabilities = require('lsp').capabilities(),
  on_attach = function(client, bufnr)
    require('lsp').on_attach(client, bufnr)
  end,
})

local elixir = require("elixir")
local elixirls = require("elixir.elixirls")
elixir.setup {
  elixirls = {
    capabilities = require('lsp').capabilities(),
    on_attach = function(client, bufnr)
      vim.keymap.set("n", "<leader>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
      vim.keymap.set("n", "<leader>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
      vim.keymap.set("v", "<leader>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
      require('lsp').on_attach(client, bufnr)
    end,
    settings = elixirls.settings {
      dialyzerEnabled = true,
      fetchDeps = true,
      enableTestLenses = false,
      suggestSpecs = true,
    },
  }
}

require('lspconfig').nil_ls.setup({
  autostart = true,
  capabilities = require('lsp').capabilities(),
  on_attach = function(client, bufnr)
    require('lsp').on_attach(client, bufnr)
  end,
  settings = {
    ['nil'] = {
      formatting = {
        command = { "nixpkgs-fmt" }
      },
    },
  },
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

