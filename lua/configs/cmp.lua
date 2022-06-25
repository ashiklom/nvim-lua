vim.opt.completeopt = "menu,menuone,noselect"

local cmp = require("cmp")
local luasnip = require('luasnip')

cmp.setup {
  completion = { autocomplete = false },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    })
  }),
  sources = cmp.config.sources({
    {name = 'nvim_lsp'},
    {name = 'path'},
    {name = 'calc'},
    {name = 'nvim_lua'},
    {name = 'omni'},
    {name = 'luasnip'}
  }, {
    { name = "buffer" }
  })
}
