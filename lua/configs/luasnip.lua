local ok, luasnip = pcall(require, 'luasnip')

if ok then
  require("luasnip.loaders.from_lua").lazy_load()
  require("luasnip.loaders.from_snipmate").lazy_load()

  local function tab_complete()
    if luasnip.expand_or_jumpable() then
      return luasnip.expand_or_jump()
    else
      local tab = vim.api.nvim_replace_termcodes('<Tab>', true, true, true)
      return vim.api.nvim_feedkeys(tab, 't', true)
    end
  end

  vim.keymap.set("i", "<Tab>", tab_complete)
end
