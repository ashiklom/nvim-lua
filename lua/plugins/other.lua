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
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { 'nvim-tree/nvim-web-devicons' }
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
    config = function()
      require("luasnip.loaders.from_lua").lazy_load()
      require("luasnip.loaders.from_snipmate").lazy_load()
    end,
    keys = {
      {
        "<tab>",
        function()
          -- return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
          local lsp = require('luasnip')
          if lsp.expand_or_jumpable() then
            return "<Plug>luasnip-expand-or-jump"
          else
            return "<tab>"
          end
        end,
        expr = true, silent = true, mode = "i",
      },
      { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
  },

  {
    'chrisbra/csv.vim',
    ft = {'csv'}
  },

  { 'jxnblk/vim-mdx-js' },
  { 'mracos/mermaid.vim', ft = {"mermaid"} },
  { 'eigenfoo/stan-vim' }

}
