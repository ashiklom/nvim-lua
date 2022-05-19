local iron = require('iron.core')

local function bbind(mode, map, command)
  vim.keymap.set(mode, map, command, {silent=true, buffer=true})
end

local ctrlc = string.char(03)

bbind('n', '<localleader>rf', [[:IronRepl<CR>]])
bbind('n', '<localleader>rr', iron.repl_restart)
bbind('n', '<localleader>rq', iron.close_repl)
bbind('n', '<localleader><Tab>', [[:IronFocus<CR>]])

bbind('n', '<localleader>l', iron.send_line)
bbind('n', '<localleader>x', function() iron.send(nil, ctrlc) end)

bbind('v', '<localleader>ss', iron.visual_send)

bbind("n", "<localleader>rp", function()
  local cmd = string.format('print(%s)', vim.fn.expand('<cword>'))
  iron.send(nil, {cmd})
end)
