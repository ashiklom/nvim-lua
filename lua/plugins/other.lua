return {
  { 'nvim-lua/plenary.nvim' },

  { 'danro/rename.vim' },

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

  {'junegunn/fzf.vim', dependencies = {{'junegunn/fzf'}}},
  {
      'kyazdani42/nvim-tree.lua',
      dependencies = 'kyazdani42/nvim-web-devicons',
      config = function() require("configs.nvim-tree") end
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

  {
    'TimUntersberger/neogit',
    config = function() require('configs.neogit') end
  },
  { 'lewis6991/gitsigns.nvim', config = function() require('configs.conf_gitsigns') end },
  { 'samoshkin/vim-mergetool', config = function() require('configs.vim-mergetool') end },

  {
    'akinsho/nvim-toggleterm.lua',
    config = function() require('configs.nvim-toggleterm') end
  },

  { 'vim-pandoc/vim-pandoc' },
  { 'vim-pandoc/vim-pandoc-syntax' },

  { 'sainnhe/sonokai' },
  { 'nvim-lualine/lualine.nvim', config = function() require('configs.lualine') end },

  {
    'L3MON4D3/LuaSnip',
    config = function() require('configs.luasnip') end
  },

  {
    'chrisbra/csv.vim',
    ft = {'csv'}
  },

  { 'jxnblk/vim-mdx-js' },
  { 'mracos/mermaid.vim', ft = {"mermaid"} },
  { 'eigenfoo/stan-vim' }

}
