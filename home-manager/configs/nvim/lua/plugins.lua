require('packer').init({ luarocks = { python_cmd = "python3" }})
return require('packer').startup(function()
  use {
    'wbthomason/packer.nvim', 
    config = function() 
      -- Auto rebuild packer cache 
      vim.cmd [[augroup PackerCompile ]]
      vim.cmd [[ au! ]]
      vim.cmd [[autocmd BufWritePost plugins.lua PackerCompile]]
      vim.cmd [[augroup end]]
    end
  }
  use { 'lewis6991/impatient.nvim' }
  -- LSP {{{
  use {
    'neovim/nvim-lspconfig',
    config = function() 
      local servers = { 
        'bashls',
        'cssls',
        'dartls',
        'dockerls',
        'rnix',
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

      require('lspconfig').pyright.setup({
        capabilities = require('lsp').capabilities(),
        on_attach = require('lsp').on_attach,
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = "openFilesOnly",
              typeCheckingMode = "off",
              useLibraryCodeForTypes = true,
            },
          },
        }
      })

      require'lspconfig'.tsserver.setup({
        init_options = require("nvim-lsp-ts-utils").init_options,
        capabilities = require('lsp').capabilities(),
        on_attach = function(client, bufnr)
          client.resolved_capabilities.document_formatting = false
          client.resolved_capabilities.document_range_formatting = false

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
    end
  }

  use 'jose-elias-alvarez/nvim-lsp-ts-utils'

  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      local null_ls = require('null-ls')
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettierd,
          null_ls.builtins.formatting.fish_indent,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,
          null_ls.builtins.diagnostics.eslint_d,
          null_ls.builtins.diagnostics.ansiblelint,
          null_ls.builtins.diagnostics.shellcheck,
          null_ls.builtins.diagnostics.flake8,
          null_ls.builtins.code_actions.eslint_d,
          null_ls.builtins.code_actions.shellcheck,
        },
        on_attach = require('lsp').on_attach
      })
    end
  }

  use {
    'nvim-lua/lsp_extensions.nvim',
    module = 'lsp_extensions'
  }

  use {
    'RishabhRD/nvim-lsputils',
    module = 'lsputil',
    requires = { 
      {
        'RishabhRD/popfix',
        module = 'popfix'
      }
    }
  }

  use { 
    'kosayoda/nvim-lightbulb', 
    module = 'nvim-lightbulb'
  }

  use {
    'folke/trouble.nvim',
    cmd = { 'Trouble', 'TroubleClose', 'TroubleToggle', 'TroubleRefresh' },
    module = 'trouble',
  }

  use {
    'weilbith/nvim-code-action-menu',
    cmd = 'CodeActionMenu',
    config = function ()
      vim.g.code_action_menu_show_diff = false
    end
  }

  use {
    'onsails/lspkind-nvim',
    module = 'lspkind'
  }

  use {
    'ray-x/lsp_signature.nvim',
    module = 'lsp_signature'
    }

  use {
    'nvim-lua/lsp-status.nvim', 
    module = 'lsp-status',
    config = function() 
      local lsp_status = require('lsp-status')
      lsp_status.register_progress() 
      lsp_status.config({
        diagnostics = false,
        current_function = false,
        status_symbol = ''
      }) 
    end
  }

  use {
    'simrat39/rust-tools.nvim',
    ft = 'rust',
    after = 'nvim-dap-ui',
    config = function() 
      require('config/rust-tools')
    end
  }

  use {
    'elixir-lang/vim-elixir', 
    ft = 'elixir',
    config = function()
      require('lspconfig').elixirls.setup{
        capabilities = require('lsp').capabilities(),
        on_attach = require('lsp').on_attach,
        cmd = { "/usr/home/xanderio/local_build/elixir-ls_release/language_server.sh" }
      }
    end
  }
  
  

  -- }}}
  -- DAP {{{
  use { 
    {
      "mfussenegger/nvim-dap",
      config = function()
        require('config.dap')
      end
    },
    {
      "rcarriga/nvim-dap-ui", 
      config = function()
        require('dapui').setup()
      end
    }
  }
  -- }}}
  -- Treesitter {{{
  use { 
    'nvim-treesitter/nvim-treesitter', 
    after = 'dracula.nvim',
    config = function()
      require('config/treesitter')
    end
  }
  use {
	  "SmiteshP/nvim-gps",
	  requires = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-gps").setup()
    end
  }
  
  use {
    'mfussenegger/nvim-ts-hint-textobject',
    require = 'nvim-treesitter/nvim-treesitter',
    module = 'tsht'
  }

  -- }}}
  -- Utils {{{
  use {
    'junegunn/vim-easy-align',
    config = function()
      vim.cmd [[ xmap <leader>a <Plug>(EasyAlign) ]]
      vim.cmd [[ nmap <leader>a <Plug>(EasyAlign) ]]
    end
  }
  use {
    'iamcco/markdown-preview.nvim',
    run = 'cd app && yarn install',
    ft = 'markdown' 
  }

  use {
      'Saecki/crates.nvim',
      event = { "BufRead Cargo.toml" },
      requires = { { 'nvim-lua/plenary.nvim' } },
      config = function()
          require('crates').setup()
      end,
  }

  use {
    'shuntaka9576/preview-swagger.nvim',
    run = 'yarn install',
    ft = {'json', 'yaml', 'yml'}
  }

  use {
    'rcarriga/nvim-notify',
    config = function()
      require('config/notify')
    end
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
    config = function() 
      require('config/telescope')
    end
  }
  use 'olacin/telescope-gitmoji.nvim'

  use {
    'hoob3rt/lualine.nvim',
    config = function() 
      require("config.lualine")
    end 
  }

  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('config.gitsigns')
    end
  }

  use 'gpanders/editorconfig.nvim'
  
  use { 
    'L3MON4D3/LuaSnip', 
    config = function()
      vim.api.nvim_set_keymap("i", "<C-E>", "<Plug>luasnip-next-choice", {})
      vim.api.nvim_set_keymap("s", "<C-E>", "<Plug>luasnip-next-choice", {})
    end 
  }
  use { 'saadparwaiz1/cmp_luasnip' }
  use { 'hrsh7th/cmp-nvim-lua' }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-vsnip' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/cmp-emoji' }
  use { 'hrsh7th/cmp-calc' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-cmdline' }

  use {
    'hrsh7th/nvim-cmp',
    config = function()
      require('config.cmp')
    end,
  }

  use {
    'Mofiqul/dracula.nvim',
    config = function() 
      -- require so we don't call this twice on reload
      require('config.colorschema')
    end
  }

  use {
    'voldikss/vim-floaterm',
    config = function()
      require('config/floatterm')
    end
  }
  
  use { 
    'TimUntersberger/neogit', 
    requires = 'nvim-lua/plenary.nvim',
    config = function() 
      local neogit = require('neogit')
      neogit.setup({})
    end
  }

  use {
    'tpope/vim-surround',
    'tpope/vim-repeat',
    'tpope/vim-commentary',
    -- 'tpope/vim-fugitive' 
  }
  -- }}}
  -- FT Plugins {{{
  use 'nathom/filetype.nvim'
  use {
    'valloric/MatchTagAlways', 
    ft = {'html', 'xml'}
  }

  use {
    'thinca/vim-ref', 
    cmd = 'Ref'
  }

  use { 
    'alvan/vim-closetag', 
    ft = 'html'
  }

  use {
    'dag/vim-fish',
    ft = 'fish'
  }

  use {
    'jamessan/vim-gnupg',
    ft = {'gpg', 'mail'}
  }

  use { 
    'dbeniamine/vim-mail', 
    ft = 'mail'
  }
  -- }}}
  -- Dependencies {{{
  use {
    'kyazdani42/nvim-web-devicons',
    module = 'nvim-web-devicons'
  }
  -- }}}
end)
-- vim: fdm=marker :
