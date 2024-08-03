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
    'stevearc/oil.nvim',
    config = true,
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
}
