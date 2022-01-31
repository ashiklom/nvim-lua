local icore = require('iron.core')
local ill = require('iron.lowlevel')

vim.g.julia_indent_align_funcargs = 0
vim.g.julia_indent_align_brackets = 0
vim.g.julia_indent_align_import = 1

function _G.jl_send_func(func)
  local ft = ill.get_buffer_ft(0)
  icore.send(ft, string.format("%s()", func))
end

function _G.jl_send_func_word(func)
  local ft = ill.get_buffer_ft(0)
  local word = vim.fn.expand("<cword>")
  icore.send(ft, string.format("%s(%s)", func, word))
end

local function fbind(mode, map, func)
  local command = string.format("v:lua.jl_send_func('%s')", func)
  vim.api.nvim_buf_set_keymap(0, mode, map, command, {silent=true, noremap=true, expr=true})
end

local function fwbind(mode, map, func)
  local command = string.format("v:lua.jl_send_func_word('%s')", func)
  vim.api.nvim_buf_set_keymap(0, mode, map, command, {silent=true, noremap=true, expr=true})
end

local function bind(mode, map, command)
  vim.api.nvim_buf_set_keymap(0, mode, map, command, {silent=true})
end

local function rbind(mode, map, command)
  vim.api.nvim_buf_set_keymap(0, mode, map, command, {silent=true, noremap=true})
end

bind("n", "<localleader>l", [[<Plug>(iron-send-line)]])
bind("n", "<localleader>s", [[<Plug>(iron-send-motion)]])
bind("n", "<localleader><CR>", [[<Plug>(iron-cr)]])
bind("n", "<localleader>x", [[<Plug>(iron-interrupt)]])
bind("v", "<localleader>ss", [[<Plug>(iron-visual-send)]])

rbind("n", "<localleader>rf", [[:IronRepl<CR>]])
rbind("n", "<localleader>rr", [[:IronRestart<CR>]])
rbind("n", "<localleader>rq", [[:IronSend! exit()<CR>:IronFocus<CR>:bd!<CR>]])

-- Send current word (produces better formatting than "print")
bind('n', '<localleader>rp', '<localleader>siw')

fwbind('n', '<localleader>rP', 'print')
fbind('n', '<localleader>rz', 'isinteractive')

-- vim.api.nvim_buf_set_keymap(0, 'n', '<localleader>rp', 'v:lua.jl_send_print()', {silent=true, noremap=true, expr=true})

-- map_call('n', '<localleader>r.', 'import Pkg; Pkg.activate(".")')
-- map_call_cword('n', '<localleader>rp', 'print')
