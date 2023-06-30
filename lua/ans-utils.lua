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

local function bbind(mode, map, command)
  vim.keymap.set(mode, map, command, {silent=true, buffer=true})
end

utils.bbind = bbind

function utils.register_iron_keys(print_pattern)
  local iron = require('iron.core')

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

  -- Send entire file
  bbind('n', '<localleader>aa', function()
    -- Save the current view...
    local view = vim.fn.winsaveview()
    vim.api.nvim_feedkeys('m0', 'n', false)
    vim.api.nvim_feedkeys('ggVG', 'n', false)
    iron.visual_send()
    vim.api.nvim_feedkeys('`0', 'n', false)
    -- ...and restore it after running the command.
    vim.fn.winrestview(view)
  end)

  -- Send all lines before current
  bbind('n', '<localleader>ak', function()
    local view = vim.fn.winsaveview()
    vim.api.nvim_feedkeys('m0', 'n', false)
    vim.api.nvim_feedkeys('vgg', 'n', false)
    iron.visual_send()
    vim.api.nvim_feedkeys('`0', 'n', false)
    vim.fn.winrestview(view)
  end)

  -- Send all lines after current
  bbind('n', '<localleader>aj', function()
    local view = vim.fn.winsaveview()
    vim.api.nvim_feedkeys('m0', 'n', false)
    vim.api.nvim_feedkeys('vG', 'n', false)
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
