local packer = require("packer")
local use = packer.use

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'svermeulen/vimpeccable'
  use 'nvim-lua/plenary.nvim'

  use 'danro/rename.vim'
  use 'easymotion/vim-easymotion'

  use 'tpope/vim-surround'
  use { 'AndrewRadev/splitjoin.vim', config = function()
    vim.api.nvim_set_var('splitjoin_split_mapping', '')
    vim.api.nvim_set_var('splitjoin_join_mapping', '')
    vim.api.nvim_set_keymap('n', 'g[', [[:SplitjoinSplit<CR>]], {silent=true})
    vim.api.nvim_set_keymap('n', 'gJ', [[:SplitjoinJoin<CR>]], {silent=true})
    end
  }

  use {
    'haya14busa/incsearch.vim',
    disable=true,
    config = function()
      vim.api.nvim_set_var('incsearch#auto_nohlsearch', 1)
      vim.api.nvim_set_keymap('', '/', [[<Plug>(incsearch-forward)]], {silent=true})
      vim.api.nvim_set_keymap('', '?', [[<Plug>(incsearch-backward)]], {silent=true})
      vim.api.nvim_set_keymap('', 'g/', [[<Plug>(incsearch-stay)]], {silent=true})
      local keys = {'n', 'N', '*', '#', 'g*', 'g#'}
      for _, key in ipairs(keys) do
        local rhs = string.format('<Plug>(incsearch-%s)', key)
        vim.api.nvim_set_keymap('', key, rhs, {silent=true})
      end
    end
  }

  use {'jalvesaq/nvim-r', ft = {"r", "rmd", "rnw"}}

  -- Python
  use {'hkupty/iron.nvim'}
  use {'GCBallesteros/jupytext.vim'}

  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }

  use { 'nvim-telescope/telescope-project.nvim' }

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

  use { 'TimUntersberger/neogit', config = function() require('neogit').setup() end }
  use { 'lewis6991/gitsigns.nvim', config = function() require('gitsigns').setup() end }

  use { 'steelsojka/pears.nvim', config = function() require('pears').setup() end }

  use 'editorconfig/editorconfig-vim'
  use 'b3nj5m1n/kommentary'

  use {
    'akinsho/nvim-toggleterm.lua',
    config = function() require('toggleterm').setup{
      open_mapping = [[<c-\>]],
      direction = "float",
      hide_numbers = true
    } end
  }

  -- use 'joshdick/onedark.vim'
  use 'sainnhe/sonokai'

end)
