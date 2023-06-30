return {
  {
    'ggandor/leap.nvim',
    config = function() require('configs.leap') end
  },

  {
    'kylechui/nvim-surround',
    config = function() require('nvim-surround').setup{} end
  },
  {
    'echasnovski/mini.splitjoin',
    config = function()
      local ms = require('mini.splitjoin')
      ms.setup{
        mappings = {
          toggle = 'gS',
          split = 'g[',
          join = 'g]'
        }
      }
      vim.keymap.set('i', '<C-e>', ms.toggle, {desc="Toggle splitjoin"})
    end
  },
  {
    'windwp/nvim-autopairs',
    config = function() require('configs.nvim-autopairs') end
  },
  { 'editorconfig/editorconfig-vim' },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup{}
    end
  },
  {
    'dhruvasagar/vim-table-mode',
    ft = {'markdown'},
    -- NOTE: init to run before
    init = function() require('setups.vim-table-mode') end,
    config = function() require('configs.vim-table-mode') end
  },
  {'lukas-reineke/indent-blankline.nvim', config = function() require('configs.indent-blankline') end},

  {
    'dkarter/bullets.vim',
    init = function() require('setups.bullets') end,
    config = function() require('configs.bullets') end
  },



  -- Fallbacks for argument selection and exchange
  { 'wellle/targets.vim' },
  { 'tommcdo/vim-exchange' }
}
