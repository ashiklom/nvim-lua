local ok, luasnip = pcall(require, 'luasnip')

if ok then
  require("luasnip.loaders.from_lua").lazy_load()
  require("luasnip.loaders.from_snipmate").lazy_load()

  local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end

  _G.tab_complete = function()
    if luasnip.expand_or_jumpable() then
      return t("<Plug>luasnip-expand-or-jump")
    else
      return t("<Tab>")
    end
  end

  vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
end
