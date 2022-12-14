-- Bootstrap dep
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/deps/opt/dep'
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({"git", "clone", "--depth=1", "https://github.com/chiyadev/dep", install_path})
end

vim.cmd("packadd dep")

require "dep" {
  {'wbthomason/packer.nvim'},
  {'nvim-lua/plenary.nvim'},

  {'danro/rename.vim'},

  {
    'ggandor/leap.nvim',
    function() require('configs.leap') end
  },

  {
    'kylechui/nvim-surround',
    function() require('configs.nvim_surround') end
  },
  {
    'ashiklom/splitjoin.vim',
    function() require('configs.splitjoin') end
  },

  {
    'hkupty/iron.nvim',
    function() require('configs.iron') end
  },

  { 'kassio/neoterm' },

  -- Python
  {
    'GCBallesteros/jupytext.vim',
    config = function() require('configs.jupytext') end
  },
  { 'Vimjas/vim-python-pep8-indent' },

  { 'JuliaEditorSupport/julia-vim'},

  { 'bfredl/nvim-luadev' },

  {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
      {'yamatsum/nvim-nonicons'},
      {'kyazdani42/nvim-web-devicons'},
    },
  },
  {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
  {'nvim-telescope/telescope-project.nvim'},
  {'nvim-telescope/telescope-file-browser.nvim'},
  {
    'renerocksai/telekasten.nvim',
    requires = {{ 'renerocksai/calendar-vim' }},
    config = function() require('configs.telekasten') end
  },
  {'junegunn/fzf.vim', requires = {{'junegunn/fzf'}}},
  {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require("configs.nvim-tree") end
  },

  {
    'dkarter/bullets.vim',
    setup = function() require('setups.bullets') end,
    config = function() require('configs.bullets') end
  },

  -- Languageserver
  {
    'neovim/nvim-lspconfig',
    config = function() require('configs.lsp') end
  },
  { 'williamboman/nvim-lsp-installer' },
  {
    'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim',
    config = function() require('configs.toggle_lsp_diagnostics') end
  },

  {
    "hrsh7th/nvim-cmp",
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-calc',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-omni',
      'saadparwaiz1/cmp_luasnip'
    },
    config = function() require('configs.cmp') end
  },

  {
    'nvim-treesitter/nvim-treesitter',
    -- run = ':TSUpdate',
    config = function() require('configs.treesitter') end
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    requires = { 'nvim-treesitter/nvim-treesitter' },
  },
  -- Fallbacks for argument selection and exchange
  { 'wellle/targets.vim' },
  { 'tommcdo/vim-exchange' },

  {
    'TimUntersberger/neogit',
    config = function() require('configs.neogit') end
  },
  { 'lewis6991/gitsigns.nvim', config = function() require('configs.conf_gitsigns') end },
  { 'samoshkin/vim-mergetool', config = function() require('configs.vim-mergetool') end },

  {
    'windwp/nvim-autopairs',
    config = function() require('configs.nvim-autopairs') end
  },

  {'editorconfig/editorconfig-vim'},
  { 'b3nj5m1n/kommentary', config = function() require('configs.kommentary') end },

  {
    'dhruvasagar/vim-table-mode',
    -- NOTE: Setup to run before
    setup = function() require('setups.vim-table-mode') end,
    config = function() require('configs.vim-table-mode') end
  },

  {
    'akinsho/nvim-toggleterm.lua',
    config = function() require('configs.nvim-toggleterm') end
  },

  { 'vim-pandoc/vim-pandoc' },
  { 'vim-pandoc/vim-pandoc-syntax' },

  { 'sainnhe/sonokai' },
  {'nvim-lualine/lualine.nvim', config = function() require('configs.lualine') end},
  {'lukas-reineke/indent-blankline.nvim', config = function() require('configs.indent-blankline') end},

  {'axvr/org.vim', disable=true},
  {
    'kristijanhusak/orgmode.nvim',
    config = function() require('configs.orgmode') end
  },

  {
    "nvim-neorg/neorg",
    disable=true,
    config = function() require('configs.neorg') end
  },

  {
    'mtth/scratch.vim',
    setup = function() require('setups.scratch') end,
    config = function() require('configs.scratch') end
  },

  {
    'L3MON4D3/LuaSnip',
    config = function() require('configs.luasnip') end
  },

  {
    'chrisbra/csv.vim'
  },

  { 'jxnblk/vim-mdx-js' }

}
