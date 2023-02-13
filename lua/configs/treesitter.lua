local tconfig = require('nvim-treesitter.configs')

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.org = {
  install_info = {
    url = 'https://github.com/milisims/tree-sitter-org',
    revision = 'main',
    files = {'src/parser.c', 'src/scanner.cc'},
  },
  filetype = 'org'
}

tconfig.setup{
  indent = {
    enable=true,
    disable = {"r", "python", "yaml", "org"},
  },
  highlight = {
    enable=true,
    disable={"r", "org"},
    additional_vim_regex_highlighting = {"org"}
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
        [']m'] = '@function.outer',
        [']c'] = '@class.outer'
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']C'] = '@class.outer'
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[c'] = '@class.outer'
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[C'] = '@class.outer'
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
