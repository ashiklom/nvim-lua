local utils = {}

function utils.buf_name()
  return vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
end

local ok, _ = pcall(require, 'plenary')
if ok then
  local path = require('plenary.path')
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

  _G.buf_cwd = utils.buf_cwd
  _G.git_cwd = utils.git_cwd

end

local function bbind(mode, map, command)
  vim.keymap.set(mode, map, command, {silent=true, buffer=true})
end

utils.bbind = bbind

function utils.register_iron_keys(print_pattern)
  local iron = require('iron.core')

  -- Send all lines before current
  bbind('n', '<localleader>ak', function()
    local view = vim.fn.winsaveview()
    vim.api.nvim_feedkeys('m0', 'n', false)
    vim.api.nvim_feedkeys('-Vgg', 'n', false)
    iron.visual_send()
    vim.api.nvim_feedkeys('`0', 'n', false)
    vim.fn.winrestview(view)
  end)

  -- Send all lines after current
  bbind('n', '<localleader>aj', function()
    local view = vim.fn.winsaveview()
    vim.api.nvim_feedkeys('m0', 'n', false)
    vim.api.nvim_feedkeys('+VG', 'n', false)
    iron.visual_send()
    vim.api.nvim_feedkeys('`0', 'n', false)
    vim.fn.winrestview(view)
  end)

  bbind("n", "<localleader>rp", function()
    local cmd = string.format(print_pattern, vim.fn.expand('<cword>'))
    iron.send(nil, {cmd})
  end)
end

return utils
