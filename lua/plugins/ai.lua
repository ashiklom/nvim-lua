return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    opts = {
      suggestion = {
        enabled = true,
      }
    },
    keys = {
      { '<leader>ap', function() vim.cmd('Copilot') end, desc = "Copilot activate" },
      {'<leader>aP', function() require('copilot.suggestion').toggle_auto_trigger() end, desc = "Copilot toggle auto-trigger"},
      { '<C-l>', function() require('copilot.suggestion').next() end, mode = "i", desc = "Copilot next"},
      { '<Right>', function() require('copilot.suggestion').accept() end, mode = "i", desc = "Copilot accept"},
      { '<Left>', function() require('copilot.suggestion').dismiss() end, mode = "i", desc = "Copilot dismiss"},
      { '<Up>', function() require('copilot.suggestion').dismiss() end, mode = "i", desc = "Copilot previous"},
    }
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = { "zbirenbaum/copilot.lua" },
    keys = {
      { "<leader>ai", function() require("codecompanion").toggle() end, desc = "Codecompanion toggle chat"},
      { "<leader>aI", function() require("codecompanion").actions() end, desc = "Codecompanion actions"},
      { "<leader>ai", ':CodeCompanion ', mode = "x", desc = "Codecompanion inline"},
    },
    opts = {
      interactions = {
        chat = { adapter = "copilot" },
        inline = { adapter = "copilot" },
        cmd = { adapter = "copilot" }
      },
      adapters = {
        http = {
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
}
