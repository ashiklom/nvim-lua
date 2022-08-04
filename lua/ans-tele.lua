local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values

local my_tele = {}

local function nsearch(opts)
  opts = opts or {}
  local my_finder = finders.new_job(function(prompt)
    local command = vim.fn.stdpath("config") .. "/bin/nsearch"
    prompt = string.gsub(prompt, '%s+$', '')  -- Remove trailing spaces
    if not prompt or prompt == "" then
      return {command}
    else
      return vim.tbl_flatten{command, vim.split(prompt, " ")}
    end
  end)
  pickers.new(opts, {
    prompt_title = "Notes search",
    finder = my_finder,
    previewer = conf.file_previewer(opts)
  }):find()
end

my_tele.nsearch = nsearch

return my_tele
