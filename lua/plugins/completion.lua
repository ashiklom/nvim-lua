return {
  {
    "saghen/blink.cmp",
    dependencies = { "chrisgrieser/nvim-scissors" },
    version = "1.*",
    opts = {
      keymap = {
        preset = "super-tab",
        ['<C-space>'] = { function(cmp) cmp.show() end},
        ['<C-s>'] = { 'show_signature', 'hide_signature', 'fallback' },
      },
      completion = {
        menu = {
          auto_show = function()
            return not vim.tbl_contains({"markdown", "quarto"}, vim.bo.filetype)
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
      },
      signature = {
        enabled = true,
        trigger = {
          enabled = false
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
