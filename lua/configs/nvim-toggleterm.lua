local tt = require('toggleterm')

tt.setup{
  open_mapping = [[<c-\>]],
  direction = "float",
  hide_numbers = true
}

local function set_term_keymaps()
  local opts = {buffer=true}
  vim.keymap.set('t', '<M-i>', [[<C-\><C-n>]], opts)
end

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("ansauto_TermKeys", {clear = true}),
  pattern = {"term://*"},
  callback = set_term_keymaps
})
