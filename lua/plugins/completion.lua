return {
  {
    "saghen/blink.cmp",
    dependencies = { "chrisgrieser/nvim-scissors" },
    version = "1.*",
    opts = {
      keymap = {
        preset = "super-tab",
        ['<C-space>'] = { function(cmp) cmp.show() end}
      },
      completion = {
        menu = {
          -- If copilot is enabled, do not show the menu
          auto_show = function(_)
            if vim.fn.exists("copilot#Enabled") ~= 1 then
              return true
            end
            if vim.fn["copilot#Enabled"]() == 0 then
              -- Manually disabled, so auto-complete.
              return true
            end
            -- Enabled but possibly not on *yet*. Look for it in the LSP clients.
            for _, client in ipairs(vim.lsp.get_clients()) do
              if client.name == "GitHub Copilot" then
                return false
              end
            end
            return true
          end
        },
        list = {
          selection = {
            preselect = function (_)
              -- Prevents accidental completions while navigating a snippet
              return not require('blink.cmp').snippet_active({ direction = 1 })
            end
          }
        }
      },
      sources = {
        providers = {
          path = {
            opts = {
              get_cwd = function (_)
                return vim.fn.getcwd()
              end
            }
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
