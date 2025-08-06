return {
  {
    "github/copilot.vim",
    event = "VeryLazy",
    config = function ()
      vim.keymap.set('i', '<Right>', 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false
      })
      vim.keymap.set('i', '<Down>', '<Plug>(copilot-next)')
      vim.keymap.set('i', '<Up>', '<Plug>(copilot-previous)')
      vim.keymap.set('i', '<Left>', '<Plug>(copilot-dismiss)')
      vim.keymap.set('i', '<C-l>', '<Plug>(copilot-suggest)')
      vim.g.copilot_no_tab_map = true
      -- Disable copilot for all filetypes by default
      vim.g.copilot_filetypes = { ['*'] = false }
    end
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = { "github/copilot.vim" },
    keys = {
      { "<leader>ai", function() require("codecompanion").toggle() end, desc = "Codecompanion toggle chat"},
      { "<leader>aI", function() require("codecompanion").actions() end, desc = "Codecompanion actions"},
      { "<leader>ai", ':CodeCompanion ', mode = "x", desc = "Codecompanion inline"},
    },
    opts = {
      strategies = {
        chat = { adapter = "copilot" },
        inline = { adapter = "copilot" },
        cmd = { adapter = "copilot" }
      },
      adapters = {
        nasa_ai = function ()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              url = "https://bedrock-code-api.genai.mcp.nasa.gov",
              api_key = nil,
              chat_url = "/v1/chat/completions",
              models_endpoint = "/v1/models"
            },
            schema = {
              model = {
                default = "bedrock-claude-3.5-sonnet"
              }
            }
          })
        end
      }
    }
  }
}
