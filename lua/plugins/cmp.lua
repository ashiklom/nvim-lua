return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-calc',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-omni',
      'saadparwaiz1/cmp_luasnip',
      'jmbuhr/cmp-pandoc-references'
    },

    config = function()
      vim.opt.completeopt = {"menu", "menuone", "noselect"}
      vim.opt.shortmess:append "c"

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
          {name = 'luasnip'},
          {name = "buffer"}
        })
      }

      cmp.setup.filetype({"lua"}, {
        sources = {
          {name = "nvim_lua"}
        }
      })

      cmp.setup.filetype({"markdown", "quarto"}, {
        sources = {
          {name = "pandoc_references"},
        }
      })

    end
  }
}
