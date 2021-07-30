vim.opt.completeopt = "menuone,noselect"

require"compe".setup {
  enabled = true;
  autocomplete = false;
  min_length = 1;
  preselect = 'enable';
  documentation = true;
  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
  }
}
