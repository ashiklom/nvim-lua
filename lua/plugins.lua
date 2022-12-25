-- Bootstrap packer.nvim
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerCompile',
  group = packer_group,
  pattern = 'plugins.lua',
})

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'

  use 'danro/rename.vim'

  use {
    'ggandor/leap.nvim',
    config = function() require('configs.leap') end
  }

  use {
    'kylechui/nvim-surround',
    config = function() require('nvim-surround').setup{} end
  }
  use {
    'ashiklom/splitjoin.vim',
    config = function() require('configs.splitjoin') end
  }

  use {'ashiklom/r-vim-runtime', branch="update"}
  use {'jalvesaq/nvim-r', ft = {"r", "rmd", "rnw"}}

  use {
    'hkupty/iron.nvim',
    config = function() require('configs.iron') end
  }

  use { 'kassio/neoterm' }

  -- Python
  use {
    'GCBallesteros/jupytext.vim',
    config = function() require('configs.jupytext') end
  }
  use { 'Vimjas/vim-python-pep8-indent', ft = {"python"} }

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
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
  use {'nvim-telescope/telescope-project.nvim'}
  use {'nvim-telescope/telescope-file-browser.nvim'}
  use {
    'renerocksai/telekasten.nvim',
    requires = {{ 'renerocksai/calendar-vim' }},
    config = function() require('configs.telekasten') end
  }
  use {'junegunn/fzf.vim', requires = {{'junegunn/fzf'}}}
  use {
      'kyazdani42/nvim-tree.lua',
      requires = 'kyazdani42/nvim-web-devicons',
      config = function() require("configs.nvim-tree") end
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
  use { 'williamboman/nvim-lsp-installer' }
  use {
    'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim',
    config = function() require('configs.toggle_lsp_diagnostics') end
  }

  use {
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
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    -- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation#packernvim
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
    config = function() require('configs.treesitter') end
  }
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    requires = { 'nvim-treesitter/nvim-treesitter' }
  }
  -- Fallbacks for argument selection and exchange
  use { 'wellle/targets.vim' }
  use { 'tommcdo/vim-exchange' }

  use {
    'TimUntersberger/neogit',
    config = function() require('configs.neogit') end
  }
  use { 'lewis6991/gitsigns.nvim', config = function() require('configs.conf_gitsigns') end }
  use { 'samoshkin/vim-mergetool', config = function() require('configs.vim-mergetool') end }

  use {
    'windwp/nvim-autopairs',
    config = function() require('configs.nvim-autopairs') end
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

  use { 'vim-pandoc/vim-pandoc' }
  use { 'vim-pandoc/vim-pandoc-syntax' }

  use 'sainnhe/sonokai'
  use {'nvim-lualine/lualine.nvim', config = function() require('configs.lualine') end}
  use {'lukas-reineke/indent-blankline.nvim', config = function() require('configs.indent-blankline') end}

  use {'axvr/org.vim', disable=true}
  use {
    'kristijanhusak/orgmode.nvim',
    config = function() require('configs.orgmode') end
  }

  use {
    "nvim-neorg/neorg",
    disable=true,
    config = function() require('configs.neorg') end
  }

  use {
    'mtth/scratch.vim',
    setup = function() require('setups.scratch') end,
    config = function() require('configs.scratch') end
  }

  use {
    'L3MON4D3/LuaSnip',
    config = function() require('configs.luasnip') end
  }

  use {
    'chrisbra/csv.vim',
    ft = {'csv'}
  }

  use { 'jxnblk/vim-mdx-js' }

  if packer_bootstrap then
    require('packer').sync()
  end

end)
