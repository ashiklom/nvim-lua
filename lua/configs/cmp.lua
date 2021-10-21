vim.opt.completeopt = "menu,menuone,noselect"

local cmp = require("cmp")

cmp.setup {
  completion = { autocomplete = false },
  mapping = {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = true})
  },
  sources = {
    {name = 'nvim_lsp'},
    {name = 'buffer'},
    {name = 'path'},
    {name = 'calc'},
    {name = 'nvim_lua'}
  }
}
