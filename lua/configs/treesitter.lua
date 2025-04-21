local tconfig = require('nvim-treesitter.configs')

tconfig.setup{
  indent = {
    enable=true,
    disable = {"r", "yaml"},
  },
  highlight = {
    enable=true,
    disable={"r"}
  }
}
