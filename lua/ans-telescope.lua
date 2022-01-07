local telescope = require('telescope')
telescope.load_extension('project')
telescope.load_extension('file_browser')

local tb = require('telescope.builtin')
local tfb = telescope.extensions.file_browser
local path = require('plenary.path')
local utils = require('ans-utils')

local M = {}

function M.fd_files()
  local opts = {find_command = {"fd", "--type", "file"}}
  local hasgit = pcall(tb.git_files, opts)
  if not hasgit then tb.find_files(opts) end
end

function M.file_browser_cwd()
  local cwd = utils.buf_cwd()
  return tfb.file_browser({cwd=cwd})
end

-- local snap = require('snap')
-- snap.maps {
--   {'<leader>fi', snap.config.file {producer='ripgrep.file', preview=false}, {command="snapfiles"}},
--   {'<leader> ', snap.config.file {producer = 'fd.file', limit=1000}, {command="snapfd"}},
--   {'<leader>sp', snap.config.vimgrep {consumer = 'fzf'}, {command="snaprg"} }
-- }

return M
