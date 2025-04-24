return {
  -- Languageserver
  {
    "neovim/nvim-lspconfig",
    dependencies = { "blink.cmp" },
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
        terraformls = {}
      },
      on_attach = function(client, bufnr)
        if client.name == 'ruff' then
          -- Disable hover in favor of pyright
          client.server_capabilities.hoverProvider = false
        end

        if client:supports_method("textDocument/completion") then
          vim.lsp.completion.enable(true, client.id, bufnr)
        end
        vim.diagnostic.config({ virtual_text = true })
        local nmap = function(lhs, rhs, desc)
          local opts = { silent=true, buffer=bufnr, desc=desc }
          vim.keymap.set('n', lhs, rhs, opts)
        end
        nmap('gd', vim.lsp.buf.definition, "Goto definition")
        nmap('gD', vim.lsp.buf.declaration, "Goto declaration")
        nmap('gry', vim.lsp.buf.type_definition, "Goto type definition")
        nmap('<leader>so', require('telescope.builtin').lsp_document_symbols)
        nmap('<leader>tld', function()
          vim.diagnostic.enable(not vim.diagnostic.is_enabled())
        end, "Toggle LSP diagnostics")
      end
    },
    config = function(_, opts)
      local lspconfig = require('lspconfig')
      for server, config in pairs(opts.servers) do
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
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
