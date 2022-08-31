local utils = {}

function utils.augroup(group_name, event, definition)
  local grp = vim.api.nvim_create_augroup(group_name, {clear = true})
  definition["group"] = grp
  vim.api.nvim_create_autocmd(event, definition)
end

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

return utils
