-- local lsp_installer = require("nvim-lsp-installer")

local mason = require('mason').setup()
local mason_lsp = require('mason-lspconfig').setup()
local lspconfig = require('lspconfig')

-- lsp_installer.setup{}

local on_attach = function(client, bufnr)
  if client.name == 'ruff' then
    -- Disable hover in favor of pyright
    client.server_capabilities.hoverProvider = false
  end

  if client:supports_method("textDocument/completion") then
    vim.lsp.completion.enable(true, client.id, bufnr)
  end

  vim.api.nvim_buf_set_option(bufnr, 'formatexpr', 'v:lua.vim.lsp.formatexpr')

  vim.diagnostic.config({ virtual_text = true })

  local nmap = function(lhs, rhs, desc)
    local opts = { silent=true, buffer=bufnr, desc=desc }
    vim.keymap.set('n', lhs, rhs, opts)
  end
  nmap('gd', vim.lsp.buf.definition, "Goto definition")
  nmap('gD', vim.lsp.buf.declaration, "Goto declaration")
  nmap('gr', vim.lsp.buf.references, "References")
  nmap('gy', vim.lsp.buf.type_definition, "Goto type definition")
  nmap('gI', vim.lsp.buf.implementation, "Goto Implementation")
  nmap('<leader>cr', vim.lsp.buf.rename, "Rename")
  nmap('<leader>ca', vim.lsp.buf.code_action, "Code Action")
  nmap('K', vim.lsp.buf.hover, "Hover")
  nmap('<C-k>', vim.lsp.buf.signature_help)
  nmap('<leader>so', require('telescope.builtin').lsp_document_symbols)
  nmap('<leader>tld', function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  end, "Toggle LSP diagnostics")
end

-- Update capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, cmp_nl = pcall(require, 'cmp_nvim_lsp')
if ok then
  capabilities = cmp_nl.default_capabilities()
end

local servers = {
  "bashls",
  "ruff",
  "pyright",
  "lua_ls",
  "r_language_server",
  "julials",
  "terraformls"
}

for _, server in pairs(servers) do
  local opts = {
    on_attach = on_attach,
    capabilities = capabilities
  }
  if server == "lua_ls" then
    opts.settings = {Lua = {diagnostics = {globals = {"vim"}}}}
  elseif server == "bashls" then
    opts.filetypes = {"sh", "zsh"}
  elseif server == "pyright" then
    opts.settings = {
      pyright = {
        disableOrganizeImports = true
      },
    }
  end
  lspconfig[server].setup(opts)
end
