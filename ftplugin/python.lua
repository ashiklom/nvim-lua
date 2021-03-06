local iron = require('iron.core')

local function bbind(mode, map, command)
  vim.keymap.set(mode, map, command, {silent=true, buffer=true})
end

local ctrlc = string.char(03)

bbind('n', '<localleader>rf', [[:IronRepl<CR>]])
bbind('n', '<localleader>rr', iron.repl_restart)
bbind('n', '<localleader>rq', iron.close_repl)

bbind('n', '<localleader>l', iron.send_line)
bbind('n', '<localleader>x', function() iron.send(nil, ctrlc) end)

bbind('v', '<localleader>ss', iron.visual_send)

-- Send paragraph
bbind('n', '<localleader>pp', function()
  vim.api.nvim_feedkeys('m0', 'n', false)
  vim.api.nvim_feedkeys('vip', 'n', false)
  iron.visual_send()
  vim.api.nvim_feedkeys('`0', 'n', false)
end)

bbind("n", "<localleader>rp", function()
  local cmd = string.format('print(%s)', vim.fn.expand('<cword>'))
  iron.send(nil, {cmd})
end)

bbind('n', '<localleader>vr', function()
  local path = vim.fn.fnamemodify(vim.fn.expand('%:r'), ':~:.')
  local modname, _ = string.gsub(path, '/', '.')
  local cmd = string.format('import importlib; importlib.reload(%s)', modname)
  iron.send(nil, {cmd})
end)
