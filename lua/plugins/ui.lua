return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
      }
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify"
    },
    keys = {
      { "<leader>sna", function() require('noice').cmd("all") end, desc = "Noice All"},
      { "<leader>snl", function() require('noice').cmd("last") end, desc = "Noice Last Message"},
      { "<leader>snh", function() require('noice').cmd("history") end, desc = "Noice History"},
      { "<leader>snd", function() require('noice').cmd("dismiss") end, desc = "Noice Dismiss"},
      { "<leader>snt", function() require('noice').cmd("pick") end, desc = "Noice Pick"},
    }
  },

  {
    "rcarriga/nvim-notify",
    keys = {
      { "<leader>snD", function() require('notify').dismiss({ silent = true, pending = true }) end }
    },
    opts = {
      stages = "static", -- No animation
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
    }
  },

  {
    'stevearc/oil.nvim',
    config = true,
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  {
    "echasnovski/mini.bufremove",
    opts = {},
    keys = {
      { "<leader>bd", function() MiniBufremove.delete() end, desc="Delete buffer"}
    }
  }
}
