local utils = require('ans-utils')
utils.register_iron_keys('print(%s)')

local iron = require('iron.core')

utils.bbind('n', '<localleader>vr', function()
  local path = vim.fn.fnamemodify(vim.fn.expand('%:r'), ':~:.')
  local modname, _ = string.gsub(path, '/', '.')
  local cmd = string.format('import importlib; importlib.reload(%s)', modname)
  iron.send(nil, {cmd})
end)
