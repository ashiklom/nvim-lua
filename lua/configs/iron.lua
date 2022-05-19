local iron = require('iron.core')

iron.setup{config = {
  repl_open_cmd = require('iron.view').curry.bottom(15),
  repl_definition = {
    -- python = require('iron.fts.python').ipython,
    python = {command = {"ipython", "--no-autoindent"}},
    julia = {command = {"julia"}}
  }
}}
