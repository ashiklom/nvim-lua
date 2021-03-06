local iron = require('iron.core')

vim.g.julia_indent_align_funcargs = 0
vim.g.julia_indent_align_brackets = 0
vim.g.julia_indent_align_import = 1

local function fbind(mode, map, func)
  local command = string.format("v:lua.jl_send_func('%s')", func)
  vim.api.nvim_buf_set_keymap(0, mode, map, command, {silent=true, noremap=true, expr=true})
end

local function fwbind(mode, map, func)
  local command = string.format("v:lua.jl_send_func_word('%s')", func)
  vim.api.nvim_buf_set_keymap(0, mode, map, command, {silent=true, noremap=true, expr=true})
end

local function bind(mode, map, command)
  vim.keymap.set(mode, map, command, {silent=true, buffer=true})
end

bind('n', '<localleader>rf', [[:IronRepl<CR>]])
bind('n', '<localleader>rr', iron.repl_restart)
bind('n', '<localleader>rq', iron.close_repl)

bind("n", "<localleader>l", iron.send_line)
-- bind("n", "<localleader>s", [[<Plug>(iron-send-motion)]])
local ctrlc = string.char(03)
bind('n', '<localleader>x', function() iron.send(nil, ctrlc) end)
bind('v', '<localleader>ss', iron.visual_send)

-- Send current word (produces better formatting than "print")
bind('n', '<localleader>rp', function()
  iron.send(nil, {vim.fn.expand('<cword>')})
end)
bind('n', '<localleader>rP', function()
  local cmd = string.format('print(%s)', vim.fn.expand('<cword>'))
  iron.send(nil, {cmd})
end)
bind('n', '<localleader>rz', function() iron.send(nil, 'isinteractive()') end)

-- map_call('n', '<localleader>r.', 'import Pkg; Pkg.activate(".")')
-- map_call_cword('n', '<localleader>rp', 'print')
