local tconfig = require('nvim-treesitter.configs')

tconfig.setup{
  highlight = {enable=true},
  textobjects = {
    select = {
      enable = true,
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
