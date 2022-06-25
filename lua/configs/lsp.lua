local lsp_installer = require("nvim-lsp-installer")
local lspconfig = require('lspconfig')

lsp_installer.setup{}
-- local lsp_insatller_servers = require('nvim-lsp-installer.servers')

local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  local nmap = function(lhs, rhs)
    local opts = { silent=true, buffer=bufnr }
    vim.keymap.set('n', lhs, rhs, opts)
  end
  nmap('gd', vim.lsp.buf.definition)
  nmap('gD', vim.lsp.buf.declaration)
  nmap('gr', vim.lsp.buf.rename)
  nmap('K', vim.lsp.buf.hover)
  nmap('<C-k>', vim.lsp.buf.signature_help)
  nmap('gm', vim.lsp.buf.implementation)
  nmap('<leader>so', require('telescope.builtin').lsp_document_symbols)
end

-- Update capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, cmp_nl = pcall(require, 'cmp_nvim_lsp')
if ok then
  capabilities = cmp_nl.update_capabilities(capabilities)
end

lspconfig['r_language_server'].setup{
  on_attach = on_attach,
  capabilities = capabilities
}

-- for index, server in ipairs(lsp_installer.get_installed_servers()) do
--   local opts = {
--     on_attach = on_attach,
--     capabilities = capabilities
--   }
--   if server.name == "sumneko_lua" then
--     opts.settings = {Lua = {diagnostics = {globals = {"vim"}}}}
--   elseif server.name == "bashls" then
--     opts.filetypes = {"sh", "zsh"}
--   end
--   lspconfig[server].setup(opts)
-- end
