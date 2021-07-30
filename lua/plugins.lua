-- Bootstrap packer.nvim
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(fn.glob(install_path)) > 0 then
	vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
	vim.api.nvim_command 'packadd packer.nvim'
end
vim.cmd [[autocmd BufWritePost plugins.lua PackerCompile]]

local packer = require("packer")

return packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'svermeulen/vimpeccable'
  use 'nvim-lua/plenary.nvim'

  use 'danro/rename.vim'

  use { 'easymotion/vim-easymotion', disable = true }
  use {
    'ggandor/lightspeed.nvim',
    config = function() require'lightspeed'.setup{} end
  }

  use 'tpope/vim-surround'
  use {
    'AndrewRadev/splitjoin.vim',
    config = function() require('configs.splitjoin') end
  }

  use {
    'haya14busa/incsearch.vim',
    disable = true,
    config = function() require('configs.incsearch') end
  }

  use {'ashiklom/r-vim-runtime'}
  use {'jalvesaq/nvim-r', ft = {"r", "rmd", "rnw"}}

  -- Python
  use {
    'hkupty/iron.nvim',
    config = function() require('configs.iron') end
  }
  use {
    'GCBallesteros/jupytext.vim',
    config = function() require('configs.jupytext') end
  }

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
    'mcchrish/nnn.vim',
    config = function() require('configs.nnn') end
  }

  use {
    'dkarter/bullets.vim',
    setup = function() require('setups.bullets') end,
    config = function() require('configs.bullets') end
  }

  -- Languageserver
  use {
    'neovim/nvim-lspconfig',
    config = function() require('configs.lsp') end
  }
  use { 'kabouzeid/nvim-lspinstall' }

  use {
    "hrsh7th/nvim-compe",
    config = function() require('configs.compe') end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function() require('configs.treesitter') end
  }
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    requires = {{ 'nvim-treesitter/nvim-treesitter' }}
  }
  -- Fallbacks for argument selection and exchange
  use { 'wellle/targets.vim' }
  use { 'tommcdo/vim-exchange' }

  use {
    'TimUntersberger/neogit',
    config = function() require('configs.neogit') end
  }
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

  use {'axvr/org.vim', disable=true}
  use {
    'kristijanhusak/orgmode.nvim',
    config = function() require('configs.orgmode') end
  }

  use {
    "vhyrro/neorg",
    disable = true,
    config = function() require('configs.neorg') end
  }

  use {
    'mtth/scratch.vim',
    setup = function() require('setups.scratch') end,
    config = function() require('configs.scratch') end
  }

end)
