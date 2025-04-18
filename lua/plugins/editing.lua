return {
  {
    'ggandor/leap.nvim',
    config = function() require('configs.leap') end
  },

  {
    'kylechui/nvim-surround',
    config = true
  },
  {
    'echasnovski/mini.splitjoin',
    config = function()
      local ms = require('mini.splitjoin')
      ms.setup{
        mappings = {
          toggle = 'g[',
          split = 'g{',
          join = 'g}'
        }
      }
      vim.keymap.set('i', '<C-e>', ms.toggle, {desc="Toggle splitjoin"})
    end
  },
  {
    'echasnovski/mini.pairs',
    opts = {}
  },
  {
    'windwp/nvim-autopairs',
    enabled = false,
    event = "InsertEnter",
    opts = {fast_wrap = { map = "<C-l>" }},
  },
  { 'editorconfig/editorconfig-vim' },
  {
    'dhruvasagar/vim-table-mode',
    ft = {'markdown'},
    -- NOTE: init to run before
    init = function() require('setups.vim-table-mode') end,
    config = function() require('configs.vim-table-mode') end
  },
  {'lukas-reineke/indent-blankline.nvim', main = "ibl", opts = {
    indent = {char = "┊"}
  }},

  -- Fallbacks for argument selection and exchange
  {
    'echasnovski/mini.ai',
    opts = {
      mappings = {
        goto_left = 'gs[',
        goto_right = 'gs]'
      }
    }
  },
  {
    "gbprod/substitute.nvim",
    keys = {
      {"gx", function() require('substitute.exchange').visual() end, mode="x", noremap=true},
      {"gx", function() require('substitute.exchange').operator() end, noremap=true},
      {"gX", function() require('substitute.exchange').line() end, noremap=true}
    },
    opts = {}
  },
  {
    "stevearc/conform.nvim",
    keys = {
      {"<leader>fm", function() require('conform').format({async = true}) end, desc = "Format buffer"}
    },
    opts = {
      formatters_by_ft = {
        lua = {"stylua"},
        python = {"isort", "black"},
        r = {"air"},
        hcl = {"hclfmt"},
        sh = {"shfmt"}
      },
      default_format_opts = {
        lsp_format = "fallback"
      }
    }
  },
  {
    "magicduck/grug-far.nvim",
    opts = {},
    keys = {
      {
        "<leader>rf",
        function() require('grug-far').open({ prefills = { paths = vim.fn.expand("%") } }) end,
        desc = "Find-replace current file"
      },
      {
        "<leader>rp",
        function() require('grug-far').open() end,
        desc = "Find-replace current project"
      },
      {
        "<leader>rf",
        function() require('grug-far').with_visual_selection({
          prefills = { search = vim.fn.expand("<cword>"), paths = vim.fn.expand("%") }
        }) end,
        mode = "x",
        desc = "Find-replace selection"
      },
      {
        "<leader>rp",
        function() require('grug-far').with_visual_selection({
          prefills = { search = vim.fn.expand("<cword>") }
        }) end,
        mode = "x",
        desc = "Find-replace selection"
      },
    }
  }
}
