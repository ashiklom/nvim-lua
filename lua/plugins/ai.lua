return {
  {
    "olimorris/codecompanion.nvim",
    keys = {
      { "<leader>aa", function() require("codecompanion").toggle() end, desc = "Codecompanion toggle chat"},
      { "<leader>ac", function() require("codecompanion").actions() end, desc = "Codecompanion actions"},
      { "<leader>aa", ':CodeCompanion ', mode = "x", desc = "Codecompanion inline"},
    },
    opts = {
      strategies = {
        chat = { adapter = "nasa_ai" },
        inline = { adapter = "nasa_ai" },
        cmd = { adapter = "nasa_ai" }
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
