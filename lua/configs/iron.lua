local iron = require('iron.core')

iron.setup{config = {
  repl_open_cmd = 'belowright 15 split',
  repl_definition = {
    python = require('iron.fts.python').ipython,
    julia = {command = {"julia"}}
  }
}}
