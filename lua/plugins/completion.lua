return {
  {
    "saghen/blink.cmp",
    dependencies = { "chrisgrieser/nvim-scissors" },
    version = "1.*",
    opts = {
      keymap = { preset = "super-tab" },
      completion = {
        list = {
          selection = {
            preselect = function (_)
              -- Prevents accidental completions while navigating a snippet
              return not require('blink.cmp').snippet_active({ direction = 1 })
            end
          }
        }
      }
    },
  },
  {
    "chrisgrieser/nvim-scissors",
    opts = {
      snippetDir = vim.fn.stdpath("config") .. "/snippets",
    },
    keys = {
      {"<leader>ne", function() require('scissors').editSnippet() end, desc = "Edit snippet"},
      {"<leader>na", function() require('scissors').addNewSnippet() end, mode = {"n", "x"}, desc = "Add new snippet"},
    }
  },
}
