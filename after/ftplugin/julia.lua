local iron = require('iron.core')

vim.g.julia_indent_align_funcargs = 0
vim.g.julia_indent_align_brackets = 0
vim.g.julia_indent_align_import = 1

local function bind(mode, map, command, desc)
  vim.keymap.set(mode, map, command, {silent=true, buffer=true, desc=desc})
end

bind('n', '<localleader>r.', function() iron.send(nil, 'import Pkg; Pkg.activate(".")') end, "Activate package in CWD")

-- bind("n", "<localleader>s", [[<Plug>(iron-send-motion)]])

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
