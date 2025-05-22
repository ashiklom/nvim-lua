

return {
  -- Languageserver
  {
    "neovim/nvim-lspconfig",
    dependencies = { "blink.cmp" },
    init = function ()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("ansauto_lsp", {clear = true}),
        callback = function (_)
          vim.diagnostic.config({ virtual_text = true })
          local nmap = function(lhs, rhs, desc)
            local opts = { silent=true, buffer=0, desc=desc }
            vim.keymap.set({"n", "x"}, lhs, rhs, opts)
          end
          nmap('gd', vim.lsp.buf.definition, "Goto definition")
          nmap('gD', vim.lsp.buf.declaration, "Goto declaration")
          nmap('gry', vim.lsp.buf.type_definition, "Goto type definition")
          nmap('<leader>gz', function()
            vim.diagnostic.enable(not vim.diagnostic.is_enabled())
          end, "Toggle LSP diagnostics")
        end
      })
    end,
    opts = {
      servers = {
        bashls = {
          filetypes = {"sh", "zsh"}
        },
        ruff = {},
        pyright = {
          settings = { pyright = { disableOrganizeImports = true } }
        },
        lua_ls = {
          settings = { Lua = {diagnostics = {globals = {"vim"}}} }
        },
        air = {},
        julials = {},
        terraformls = {},
        ansiblels = {},
        dockerls = {
          capabilities = {
            textDocument = {
              completion = {
                completionItem = {
                  snippetSupport = false
                }
              }
            }
          }
        }
      },
    },
    config = function(_, opts)
      for server, config in pairs(opts.servers) do
        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end
    end
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {"williamboman/mason.nvim"},
    opts = {}
  },
  {
    'williamboman/mason.nvim',
    cmd = "Mason",
    opts = {}
  }
}
