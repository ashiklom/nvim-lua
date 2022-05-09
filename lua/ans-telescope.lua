local telescope = require('telescope')
telescope.load_extension('project')
telescope.load_extension('file_browser')
telescope.load_extension('fzf')

local tfb = telescope.extensions.file_browser
local utils = require('ans-utils')

local M = {}

function M.file_browser_cwd()
  local cwd = utils.buf_cwd()
  return tfb.file_browser({cwd=cwd})
end

return M
