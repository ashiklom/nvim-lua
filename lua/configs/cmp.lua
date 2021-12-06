vim.opt.completeopt = "menu,menuone,noselect"

local cmp = require("cmp")

cmp.setup {
  completion = { autocomplete = false },
  mapping = {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = true})
  },
  sources = cmp.config.sources({
    {name = 'nvim_lsp'},
    {name = 'path'},
    {name = 'calc'},
    {name = 'nvim_lua'},
    {name = 'omni'}
  }, {
    { name = "buffer" }
  })
}
