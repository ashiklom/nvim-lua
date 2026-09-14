-- Run LSP inside a venv (using uv) or pixi if appropriate
local function try_pixi_venv(cmd)
  local hasuv = vim.fn.executable("uv") == 1
  local haspixi = vim.fn.executable("pixi") == 1
  local venvdir = "./.venv"
  local pixidir = "./.pixi"
  if hasuv and (vim.fn.isdirectory(venvdir) == 1) then
    return vim.list_extend({"uv", "run"}, cmd)
  end
  -- NOTE: Also skip home directory (which has a `.pixi` folder, but with a different purpose)
  if haspixi and (vim.fn.isdirectory(pixidir) == 1) and (vim.fn.getcwd() ~= vim.env.HOME) then
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
        -- pyright = {
        --   cmd = try_pixi_venv({"pyright-langserver", "--stdio"}),
        --   handlers = {
        --     ["textDocument/publishDiagnostics"] = function() end
        --   },
        --   on_attach = function(client, _)
        --     client.server_capabilities.renameProvider = true
        --     -- Explicitly disable some capabilities
        --     client.server_capabilities.hoverProvider = false
        --     client.server_capabilities.definitionProvider = false
        --     client.server_capabilities.declarationProvider = false
        --   end,
        --   settings = { pyright = { disableOrganizeImports = true } }
        -- },
        lua_ls = {
          settings = { Lua = {diagnostics = {globals = {"vim"}}} }
        },
        air = {},
        r_language_server = {
          on_attach = function(client, _)
            -- Disable formatting; that should be handled by `air`
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end
        },
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
      -- 1. Intercept the low-level RPC dispatch callback where INVALID_SERVER_MESSAGE is logged
      -- This is a workaround around an r_language_server issue.
      local orig_rpc_start = vim.lsp.rpc.start
      vim.lsp.rpc.start = function(cmd, dispatchers, extra_spawn_params)
        if dispatchers and dispatchers.on_error then
          local orig_on_error = dispatchers.on_error
          dispatchers.on_error = function(code, err, ...)
            -- Suppress error code 1 (INVALID_SERVER_MESSAGE) containing superseded request errors
            if type(err) == "table" and err.error and err.error.code == -32800 then
              return
            end
            if type(err) == "string" and err:find("superseded") then
              return
            end
            orig_on_error(code, err, ...)
          end
        end
        return orig_rpc_start(cmd, dispatchers, extra_spawn_params)
      end

      -- Enable configured servers
      for server, config in pairs(opts.servers) do
        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end
    end
  }
}
