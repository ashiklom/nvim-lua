-- Run LSP inside a venv (using uv) or pixi if appropriate
local function try_pixi_venv(cmd)
  local hasuv = vim.fn.executable("uv") == 1
  local haspixi = vim.fn.executable("pixi") == 1
  local venvdir = "./.venv"
  local pixidir = "./.pixi"
  if hasuv and (vim.fn.isdirectory(venvdir) == 1) then
    return vim.list_extend({"uv", "run"}, cmd)
  end
  if haspixi and (vim.fn.isdirectory(pixidir) == 1) then
    return vim.list_extend({"pixi", "run"}, cmd)
  end
  return cmd
end

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
        -- Use ty for most things.
        ty = {
          cmd = try_pixi_venv({"ty", "server"})
        },
        ruff = {
          cmd = try_pixi_venv({"ruff", "server"}),
          on_attach = function (client, _)
            -- Disable hover provider (prevent "no information message")
            client.server_capabilities.hoverProvider = false
          end
        },
        pyright = {
          cmd = try_pixi_venv({"pyright-langserver", "--stdio"}),
          handlers = {
            ["textDocument/publishDiagnostics"] = function() end
          },
          on_attach = function(client, _)
            client.server_capabilities.renameProvider = true
            -- Explicitly disable some capabilities
            client.server_capabilities.hoverProvider = false
            client.server_capabilities.definitionProvider = false
            client.server_capabilities.declarationProvider = false
          end,
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
