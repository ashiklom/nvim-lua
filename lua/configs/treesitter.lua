local tconfig = require('nvim-treesitter.configs')

tconfig.setup{
  indent = {enable=true},
  highlight = {enable=true, disable={"r"}},
  textobjects = {
    select = {
      enable = true,
      disable = {"r"},
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner"
      }
    },
    swap = {
      enable = true,
      swap_next = {
        ["]a"] = "@parameter.inner"
      },
      swap_previous = {
        ["[a"] = "@parameter.inner"
      }
    }
  }
}
