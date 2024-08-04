local tconfig = require('nvim-treesitter.configs')

tconfig.setup{
  indent = {
    enable=true,
    disable = {"r", "python", "yaml"},
  },
  highlight = {
    enable=true,
    disable={"r"}
  },
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
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        [']f'] = '@function.outer',
        [']c'] = '@class.outer',
        [']a'] = '@parameter.outer'
      },
      goto_next_end = {
        [']F'] = '@function.outer',
        [']C'] = '@class.outer',
        [']A'] = '@parameter.outer'
      },
      goto_previous_start = {
        ['[f'] = '@function.outer',
        ['[c'] = '@class.outer',
        ['[a'] = '@parameter.outer'
      },
      goto_previous_end = {
        ['[F'] = '@function.outer',
        ['[C'] = '@class.outer',
        ['[A'] = '@parameter.outer'
      }
    },
    swap = {
      enable = true,
      swap_next = {
        ["]x"] = "@parameter.inner"
      },
      swap_previous = {
        ["[x"] = "@parameter.inner"
      }
    }
  }
}
