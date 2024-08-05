local iron = require('iron.core')

local pyrepl = {
  command = {"ipython", "--no-autoindent", "--no-confirm-exit"},
  format = require('iron.fts.common').bracketed_paste
}

iron.setup{config = {
  repl_open_cmd = 'botright 15 split',
  buflisted = true,
  repl_definition = {
    python = pyrepl,
    r = {command = {"R"}},
    julia = {command = {"julia"}},
    sh = {command = {"bash"}},
    ps1 = {command = {"/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe"}}
  }
}}
