local iron = require('iron.core')

local pyrepl = {
  -- `python -m IPython` ensures we're always using the curren venv's IPython
  command = {"python", "-m", "IPython", "--no-autoindent", "--no-confirm-exit"},
  format = require('iron.fts.common').bracketed_paste
}

iron.setup{config = {
  repl_open_cmd = 'botright 15 split',
  buflisted = true,
  repl_definition = {
    -- python = require('iron.fts.python').ipython,
    python = pyrepl,
    r = {command = {"R"}},
    julia = {command = {"julia"}},
    sh = {command = {"bash"}},
    ps1 = {command = {"/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe"}}
  }
}}
