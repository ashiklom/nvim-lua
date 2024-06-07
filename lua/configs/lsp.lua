-- local lsp_installer = require("nvim-lsp-installer")

local mason = require('mason').setup()
local mason_lsp = require('mason-lspconfig').setup()
local lspconfig = require('lspconfig')

-- lsp_installer.setup{}

local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  vim.api.nvim_buf_set_option(bufnr, 'formatexpr', 'v:lua.vim.lsp.formatexpr')
  local nmap = function(lhs, rhs)
    local opts = { silent=true, buffer=bufnr }
    vim.keymap.set('n', lhs, rhs, opts)
  end
  nmap('gd', vim.lsp.buf.definition)
  nmap('gD', vim.lsp.buf.declaration)
  nmap('gr', vim.lsp.buf.rename)
  nmap('K', vim.lsp.buf.hover)
  nmap('<leader>?', vim.diagnostic.open_float)
  nmap('<C-k>', vim.lsp.buf.signature_help)
  nmap('gm', vim.lsp.buf.implementation)
  nmap('<leader>so', require('telescope.builtin').lsp_document_symbols)
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
  "lua_ls",
  "r_language_server",
  "julials"
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
  end
  lspconfig[server].setup(opts)
end
