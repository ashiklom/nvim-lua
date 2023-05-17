-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

return require('lazy').setup{
  'nvim-lua/plenary.nvim',

  'danro/rename.vim',

  {
    'ggandor/leap.nvim',
    config = function() require('configs.leap') end
  },

  {
    'kylechui/nvim-surround',
    config = function() require('nvim-surround').setup{} end
  },
  {
    'ashiklom/splitjoin.vim',
    config = function() require('configs.splitjoin') end
  },

  {'ashiklom/r-vim-runtime', branch="update"},
  {
    'jalvesaq/nvim-r',
    ft = {"r", "rmd", "rnw"},
    dependencies = {'jalvesaq/cmp-nvim-r'}
  },

  {
    'hkupty/iron.nvim',
    config = function() require('configs.iron') end
  },

  { 'kassio/neoterm' },

  -- Python
  {
    'GCBallesteros/jupytext.vim',
    config = function() require('configs.jupytext') end
  },
  { 'Vimjas/vim-python-pep8-indent', ft = {"python"} },

  { 'JuliaEditorSupport/julia-vim'},

  { 'bfredl/nvim-luadev' },

  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
      {'yamatsum/nvim-nonicons'},
      {'kyazdani42/nvim-web-devicons'}
    }
  },
  {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
  {'nvim-telescope/telescope-project.nvim'},
  {'nvim-telescope/telescope-file-browser.nvim'},
  {
    'renerocksai/telekasten.nvim',
    dependencies = {{ 'renerocksai/calendar-vim' }},
    config = function() require('configs.telekasten') end
  },
  {'junegunn/fzf.vim', dependencies = {{'junegunn/fzf'}}},
  {
      'kyazdani42/nvim-tree.lua',
      dependencies = 'kyazdani42/nvim-web-devicons',
      config = function() require("configs.nvim-tree") end
  },

  {
    'dkarter/bullets.vim',
    init = function() require('setups.bullets') end,
    config = function() require('configs.bullets') end
  },

  -- Languageserver
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig"
    },
    config = function() require('configs.lsp') end
  },
  {
    'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim',
    config = function() require('configs.toggle_lsp_diagnostics') end
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
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
    -- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation#packernvim
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
    config = function() require('configs.treesitter') end
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' }
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

  'editorconfig/editorconfig-vim',
  { 'b3nj5m1n/kommentary', config = function() require('configs.kommentary') end },

  {
    'dhruvasagar/vim-table-mode',
    ft = {'markdown'},
    -- NOTE: init to run before
    init = function() require('setups.vim-table-mode') end,
    config = function() require('configs.vim-table-mode') end
  },

  {
    'akinsho/nvim-toggleterm.lua',
    config = function() require('configs.nvim-toggleterm') end
  },

  { 'vim-pandoc/vim-pandoc' },
  { 'vim-pandoc/vim-pandoc-syntax' },

  'sainnhe/sonokai',
  {'nvim-lualine/lualine.nvim', config = function() require('configs.lualine') end},
  {'lukas-reineke/indent-blankline.nvim', config = function() require('configs.indent-blankline') end},

  -- {
  --   'kristijanhusak/orgmode.nvim',
  --   config = function() require('configs.orgmode') end
  -- },

  {
    'mtth/scratch.vim',
    init = function() require('setups.scratch') end,
    config = function() require('configs.scratch') end
  },

  {
    'L3MON4D3/LuaSnip',
    config = function() require('configs.luasnip') end
  },

  {
    'chrisbra/csv.vim',
    ft = {'csv'}
  },

  { 'jxnblk/vim-mdx-js' },
  { 'mracos/mermaid.vim', ft = {"mermaid"} }

}
