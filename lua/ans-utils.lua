local path = require('plenary.path')

local utils = {}

function utils.nvim_create_augroup(group_name, definition)
  vim.api.nvim_command('augroup '..group_name)
  vim.api.nvim_command('autocmd!')
  for _, def in ipairs(definition) do
    local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
    vim.api.nvim_command(command)
  end
  vim.api.nvim_command('augroup END')
end

function utils.buf_name()
  return vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
end

function utils.git_cwd()
  local bufname = utils.buf_name()
  local buffer = path:new(bufname)
  local cwd
  if bufname == '' or string.find(bufname, 'term:') then
    cwd = tostring(vim.fn["getcwd"]())
  elseif buffer:is_dir() then
    cwd = tostring(buffer)
  else
    cwd = tostring(buffer:parent())
  end
  local result = vim.fn.systemlist(string.format("git -C %s rev-parse --show-toplevel", cwd))[1]
  if string.find(result, "fatal") then
    return cwd
  else
    return result
  end
end

function utils.buf_cwd()
  local bufname = utils.buf_name()
  if bufname == '' then
    return vim.fn["getcwd"]()
  end
  local buffer = path:new(bufname)
  if buffer:is_dir() then
    return tostring(buffer)
  end
  local cwd = buffer:parent()
  return tostring(cwd)
end

function utils.reload_vimrc()
  -- Reset 'require' cache
  package.loaded["ans-keys"] = nil
  package.loaded["ans-utils"] = nil
  package.loaded["ans-opt"] = nil
  package.loaded["ans-event"] = nil
  package.loaded["plugins"] = nil
  vim.cmd [[luafile ~/.config/nvim/init.lua]]
  print("Reloaded vimrc!")
end

_G.buf_cwd = utils.buf_cwd
_G.git_cwd = utils.git_cwd

return utils
