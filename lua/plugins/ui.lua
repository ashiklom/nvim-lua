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
        -- Disable auto documentation popup
        signature = {auto_open = {enabled = false}}
      },
      routes = {
        -- Show search notifications quietly
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
        -- Suppress file write notifications
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
            },
          },
          skip = true
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
    event = "VeryLazy",
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
    "stevearc/oil.nvim",
    dependencies = {
      "echasnovski/mini.bufremove"
    },
    opts = {},
    keys = {
      {"<leader>fo", function() require('oil').open() end, desc="Open file directory"}
    }
  },
  {
    "echasnovski/mini.bufremove",
    opts = {},
    keys = {
      { "<leader>bd", function() MiniBufremove.delete() end, desc="Delete buffer"}
    }
  },
  {
    "mrjones2014/smart-splits.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>wh", function() require('smart-splits').move_cursor_left() end },
      { "<leader>wj", function() require('smart-splits').move_cursor_down() end },
      { "<leader>wl", function() require('smart-splits').move_cursor_right() end },
      { "<leader>wk", function() require('smart-splits').move_cursor_up() end },
      { "<leader>ww", function() require('smart-splits').move_cursor_previous() end },
      { "<leader>w]", function() require('smart-splits').resize_right() end },
      { "<leader>w[", function() require('smart-splits').resize_left() end  },
      { "<leader>w<Up>", function() require('smart-splits').resize_up() end },
      { "<leader>w<Down>", function() require('smart-splits').resize_down() end },
      { "<leader>wH", function() require('smart-splits').swap_buf_left() end },
      { "<leader>wJ", function() require('smart-splits').swap_buf_down() end },
      { "<leader>wL", function() require('smart-splits').swap_buf_right() end },
      { "<leader>wK", function() require('smart-splits').swap_buf_up() end }
    }
  }
}
