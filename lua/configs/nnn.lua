local nnn = require('nnn')

nnn.setup({
  set_default_mappings = 0,
  replace_netrw = 1,
  action = {
    ["<c-t>"] = "tab_split",
    ["<c-s>"] = "split",
    ["<c-v>"] = "vsplit",
    ["<c-i>"] = "copy_to_clipboard"
  }
})
