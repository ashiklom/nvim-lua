local lualine = require('lualine')
lualine.setup({
  sections = {
    lualine_c = {{'filename', path = 1}}
  }
})
