local packer = require("packer")
local use = packer.use

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'svermeulen/vimpeccable'
  use 'nvim-lua/plenary.nvim'

  use 'danro/rename.vim'

  use { 'easymotion/vim-easymotion', disable = true }
  use { 'ggandor/lightspeed.nvim', config = function() require'lightspeed'.setup{} end }

  use 'tpope/vim-surround'
  use { 'AndrewRadev/splitjoin.vim', config = function() require('configs.splitjoin') end }

  use {
    'haya14busa/incsearch.vim',
    disable=true,
    config = function() require('configs.incsearch') end
  }

  use {'ashiklom/r-vim-runtime'}
  use {'jalvesaq/nvim-r', ft = {"r", "rmd", "rnw"}}

  -- Python
  use {'hkupty/iron.nvim'}
  use {'GCBallesteros/jupytext.vim'}

  use { 'JuliaEditorSupport/julia-vim'}

  use { 'bfredl/nvim-luadev' }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
      {'yamatsum/nvim-nonicons'},
      {'kyazdani42/nvim-web-devicons'}
    }
  }
  use { 'nvim-telescope/telescope-project.nvim' }
  use { 'camspiers/snap', disable=true}
  use {'junegunn/fzf.vim', requires = {{'junegunn/fzf'}}}

  use {
    'dkarter/bullets.vim',
    setup = function() require('setups.bullets') end,
    config = function() require('configs.bullets') end
  }

  -- Languageserver
  use { 'neovim/nvim-lspconfig' }
  use { 'kabouzeid/nvim-lspinstall' }

  use { "hrsh7th/nvim-compe" }

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    requires = {{ 'nvim-treesitter/nvim-treesitter' }}
  }
  -- Fallbacks for argument selection and exchange
  use { 'wellle/targets.vim' }
  use { 'tommcdo/vim-exchange' }

  use { 'TimUntersberger/neogit' }
  use { 'lewis6991/gitsigns.nvim', config = function() require('gitsigns').setup() end }
  use { 'samoshkin/vim-mergetool', config = function() require('configs.vim-mergetool') end }

  use { 'jiangmiao/auto-pairs' }
  use {
    'steelsojka/pears.nvim',
    disable = true,
    config = function() require('configs.pears') end
  }

  use 'editorconfig/editorconfig-vim'
  use { 'b3nj5m1n/kommentary', config = function() require('configs.kommentary') end }

  use {
    'dhruvasagar/vim-table-mode',
    ft = {'markdown'},
    -- NOTE: Setup to run before
    setup = function() require('setups.vim-table-mode') end,
    config = function() require('configs.vim-table-mode') end
  }

  use {
    'akinsho/nvim-toggleterm.lua',
    config = function() require('configs.nvim-toggleterm') end
  }

  use 'sainnhe/sonokai'

  use {
    'alok/notational-fzf-vim',
    config = function() require('configs.notational-fzf-vim') end
  }

  use {'axvr/org.vim'}

  use {
    "vhyrro/neorg",
    disable = true,
    config = function() require('configs.neorg') end
  }

end)
