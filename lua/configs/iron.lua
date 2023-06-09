local iron = require('iron.core')

local pyrepl = {
  command = {"ipython", "--no-autoindent", "--no-confirm-exit"},
  format = require('iron.fts.common').bracketed_paste
}

iron.setup{config = {
  repl_open_cmd = 'botright 15 split',
  buflisted = true,
  repl_definition = {
    -- python = require('iron.fts.python').ipython,
    python = pyrepl,
    r = {command = {"R"}},
    julia = {command = {"julia"}}
  }
}}
