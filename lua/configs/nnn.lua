local nnn = require('nnn')

nnn.setup({
  set_default_mappings = 0,
  replace_netrw = 1,
  session = 'local',
  action = {
    ["<c-t>"] = "tab_split",
    ["<c-s>"] = "split",
    ["<c-v>"] = "vsplit",
    ["<c-i>"] = "copy_to_clipboard"
  }
})

vim.api.nvim_set_keymap('n', '<leader>fo', [[<Cmd>NnnPicker %:p:h<CR>]], {silent=true})
vim.api.nvim_set_keymap('n', '<leader>fO', [[<Cmd>NnnPicker<CR>]], {silent=true})
