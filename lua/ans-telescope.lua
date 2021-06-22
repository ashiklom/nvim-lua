require('telescope').load_extension('project')

local tb = require('telescope.builtin')
local path = require('plenary.path')

local M = {}

function M.file_browser_home()
  return tb.file_browser({cwd="~", hidden=true})
end

function M.file_browser_cwd()
  local buffer = path:new(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()))
  local cwd = buffer:parent()
  return tb.file_browser({cwd=cwd, hidden=true})
end

return M
