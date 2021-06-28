local icore = require('iron.core')
local ill = require('iron.lowlevel')

function _G.jl_send_print()
  local ft = ill.get_buffer_ft(0)
  local word = vim.fn.expand("<cword>")
  icore.send(ft, string.format("print(%s)", word))
end

local function bbind(mode, map, command)
  vim.api.nvim_buf_set_keymap(0, mode, map, command, {silent=true})
end

local function brbind(mode, map, command)
  vim.api.nvim_buf_set_keymap(0, mode, map, command, {silent=true, noremap=true})
end

local function map_call(mode, map, call)
  local rhs = string.format([[:IronSend! %s<CR>]], call)
  bbind(mode, map, rhs)
end

local function map_call_cword(mode, map, call)
  local rhs = string.format([[:IronSend! "%s(".expand("<cword>").")"<CR>]], call)
  bbind(mode, map, rhs)
end

bbind("n", "<localleader>l", [[<Plug>(iron-send-line)]])
bbind("n", "<localleader>s", [[<Plug>(iron-send-motion)]])
bbind("n", "<localleader><CR>", [[<Plug>(iron-cr)]])
bbind("n", "<localleader>x", [[<Plug>(iron-interrupt)]])

brbind("n", "<localleader>rf", [[:IronRepl<CR>]])
brbind("n", "<localleader>rr", [[:IronRestart<CR>]])
brbind("n", "<localleader>rq", [[:IronSend! exit()<CR>:IronFocus<CR>:bd!<CR>]])

bbind("v", "<localleader>ss", [[<Plug>(iron-visual-send)]])

vim.api.nvim_buf_set_keymap(0, 'n', '<localleader>rp', 'v:lua.jl_send_print()', {silent=true, noremap=true, expr=true})

-- map_call('n', '<localleader>r.', 'import Pkg; Pkg.activate(".")')
-- map_call_cword('n', '<localleader>rp', 'print')
