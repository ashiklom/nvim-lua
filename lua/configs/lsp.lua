local lspinst = require("lspinstall")
local lspconf = require("lspconfig")

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

local server_configs = {
  lua = {
    on_attach = on_attach,
    settings = {Lua = {diagnostics = {globals = {"vim"}}}}
  },
  bash = {
    on_attach = on_attach,
    filetypes = { "sh", "zsh" }
  }
}

-- Update capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, cmp_nl = pcall(require, 'cmp_nvim_lsp')
if ok then
  capabilities = cmp_nl.update_capabilities(capabilities)
end

local function setup_servers()
  lspinst.setup()
  local servers = lspinst.installed_servers()
  table.insert(servers, "r_language_server")
  table.insert(servers, "julials")
  for _, server in pairs(servers) do
    local settings = server_configs[server]
    if settings == nil then
      settings = {
        on_attach = on_attach,
        capabilities = capabilities,
      }
    end
    lspconf[server].setup(settings)
  end
end

setup_servers()
lspinst.post_install_hook = function()
  setup_servers()
  vim.cmd("bufdo e")
end