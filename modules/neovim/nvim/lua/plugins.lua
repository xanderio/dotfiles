require('packer').init({ luarocks = { python_cmd = "python3" }})
return require('packer').startup(function()
  use 'wbthomason/packer.nvim' 
  use 'lewis6991/impatient.nvim' 
  use 'neovim/nvim-lspconfig' 

  use 'jose-elias-alvarez/nvim-lsp-ts-utils'
  use 'jose-elias-alvarez/null-ls.nvim'

  use 'nvim-lua/lsp_extensions.nvim'

  use {
    'RishabhRD/nvim-lsputils',
    requires = {{ 'RishabhRD/popfix' }}
  }

  use 'kosayoda/nvim-lightbulb'
  use 'antoinemadec/FixCursorHold.nvim'
  use 'folke/trouble.nvim'
  use 'weilbith/nvim-code-action-menu'
  use 'onsails/lspkind-nvim'
  use 'ray-x/lsp_signature.nvim' 
  use 'nvim-lua/lsp-status.nvim'
  use 'amrbashir/nvim-docs-view'
  use 'j-hui/fidget.nvim'

  use 'simrat39/rust-tools.nvim'

  use "mfussenegger/nvim-dap"
  use "rcarriga/nvim-dap-ui"

  use 'nvim-treesitter/nvim-treesitter'
  use 'SmiteshP/nvim-gps'
  use 'mfussenegger/nvim-ts-hint-textobject'
  use 'lewis6991/spellsitter.nvim'

  use 'lukas-reineke/indent-blankline.nvim' 
  use 'junegunn/vim-easy-align'

  use {
      'Saecki/crates.nvim',
      requires = { { 'nvim-lua/plenary.nvim' } }
  }

  use {
    'shuntaka9576/preview-swagger.nvim',
    run = 'yarn install',
  }

  use 'rcarriga/nvim-notify'

  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }
  use 'olacin/telescope-gitmoji.nvim'
  use 'hoob3rt/lualine.nvim' 
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use 'gpanders/editorconfig.nvim'
  
  use 'L3MON4D3/LuaSnip' 
  use 'saadparwaiz1/cmp_luasnip' 
  use 'hrsh7th/cmp-nvim-lua' 
  use 'hrsh7th/cmp-nvim-lsp' 
  use 'hrsh7th/cmp-vsnip' 
  use 'hrsh7th/cmp-path' 
  use 'hrsh7th/cmp-emoji' 
  use 'hrsh7th/cmp-calc' 
  use 'hrsh7th/cmp-buffer' 
  use 'hrsh7th/cmp-nvim-lsp-signature-help' 
  use 'hrsh7th/nvim-cmp'

  use 'Mofiqul/dracula.nvim'
  use 'voldikss/vim-floaterm' 
  
  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }

  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'tpope/vim-commentary'
  -- use 'tpope/vim-fugitive' 
  use 'dag/vim-fish' 
  use 'kyazdani42/nvim-web-devicons'
end)
