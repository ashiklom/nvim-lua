local function map(mode, lhs, rhs, noremap)
  local opts = {silent=true, noremap=noremap}
  local lhs2 = '<localleader>'..lhs
  vim.api.nvim_buf_set_keymap(0, mode, lhs2, rhs, opts)
end

map('n', 'rf', ':Luadev<CR>', true)
map('n', 'l', '<Plug>(Luadev-RunLine)', false)
map('v', 'ss', '<Plug>(Luadev-Run)', false)
