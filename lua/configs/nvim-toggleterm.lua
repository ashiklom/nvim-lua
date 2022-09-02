local tt = require('toggleterm')
local utils = require('ans-utils')

tt.setup{
  open_mapping = [[<c-\>]],
  direction = "float",
  hide_numbers = true
}

local function set_term_keymaps()
  local opts = {buffer=true}
  vim.keymap.set('t', '<M-i>', [[<C-\><C-n>]], opts)
end

utils.augroup("Termkeys", "TermOpen", {
  pattern = {"term://*"},
  callback = set_term_keymaps
})
