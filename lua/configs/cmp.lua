vim.opt.completeopt = "menu,menuone,noselect"

local cmp = require("cmp")

cmp.setup {
  completion = { autocomplete = false },
  mapping = {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<CR>'] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = true})
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' }
  }
  -- sources = cmp.config.sources({
  --   {name = 'nvim_lsp'},
  --   {name = 'path'},
  --   {name = 'calc'},
  --   {name = 'nvim_lua'},
  --   {name = 'omni'}
  -- }, {
  --   { name = "buffer" }
  -- })
}
