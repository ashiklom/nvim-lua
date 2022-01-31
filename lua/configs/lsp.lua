local lsp_installer = require("nvim-lsp-installer")
-- local lsp_insatller_servers = require('nvim-lsp-installer.servers')

local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  local nmap = function(lhs, rhs)
    local opts = { noremap=true, silent=true}
    vim.api.nvim_buf_set_keymap(bufnr, 'n', lhs, rhs, opts)
  end
  nmap('gd', [[:lua vim.lsp.buf.definition()<CR>]])
  nmap('gD', [[:lua vim.lsp.buf.declaration()<CR>]])
  nmap('gr', [[:lua vim.lsp.buf.rename()<CR>]])
  nmap('K', [[:lua vim.lsp.buf.hover()<CR>]])
end

-- Update capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, cmp_nl = pcall(require, 'cmp_nvim_lsp')
if ok then
  capabilities = cmp_nl.update_capabilities(capabilities)
end

lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = on_attach,
    capabilities = capabilities
  }
  if server.name == "sumneko_lua" then
    opts.settings = {Lua = {diagnostics = {globals = {"vim"}}}}
  elseif server.name == "bashls" then
    opts.filetypes = {"sh", "zsh"}
  end
  server:setup(opts)
end)
