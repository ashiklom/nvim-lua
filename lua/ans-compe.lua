local vimp = require('vimp')

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

-- local kopts = {silent=true, noremap=true, expr=true}
-- vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()", kopts)
-- vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm('<C-y>')", kopts)
