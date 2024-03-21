local iron = require('iron.core')

-- Don't automatically extend comments with "o"
vim.cmd [[setlocal fo-=o]]

vim.g.julia_indent_align_funcargs = 0
vim.g.julia_indent_align_brackets = 0
vim.g.julia_indent_align_import = 1

local function bind(mode, map, command, desc)
  vim.keymap.set(mode, map, command, {silent=true, buffer=true, desc=desc})
end

bind('n', '<localleader>rf', [[:IronRepl<CR>]], "Start REPL")
bind('n', '<localleader>rr', iron.repl_restart, "Restart REPL")
bind('n', '<localleader>rq', iron.close_repl, "Quit REPL")
bind('n', '<localleader>r.', function() iron.send(nil, 'import Pkg; Pkg.activate(".")') end, "Activate package in CWD")

bind("n", "<localleader>l", iron.send_line, "Send line")
-- bind("n", "<localleader>s", [[<Plug>(iron-send-motion)]])
local ctrlc = string.char(03)
bind('n', '<localleader>x', function() iron.send(nil, ctrlc) end, "Send C-C")
bind('v', '<localleader>ss', iron.visual_send, "Send selection")
bind('n', '<localleader>aa', iron.send_file, "Send file")

-- Send current word (produces better formatting than "print")
bind('n', '<localleader>rp', function()
  iron.send(nil, {vim.fn.expand('<cword>')})
end, "Send word")
bind('n', '<localleader>rP', function()
  local cmd = string.format('print(%s)', vim.fn.expand('<cword>'))
  iron.send(nil, {cmd})
end, "Print word")
bind('n', '<localleader>rz', function() iron.send(nil, 'isinteractive()') end,
  "Is interactive?")
