local tconfig = require('nvim-treesitter.configs')

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.org = {
  install_info = {
    url = 'https://github.com/milisims/tree-sitter-org',
    revision = 'main',
    files = {'src/parser.c', 'src/scanner.cc'},
  },
  filetype = 'org',
}

tconfig.setup{
  indent = {enable=true, disable = {"r", "julia"}},
  ensure_installed = {"org"},
  highlight = {
    enable=true,
    disable={"r", "org"},
    additional_vim_regex_highlighting = {"org"}
  },
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
