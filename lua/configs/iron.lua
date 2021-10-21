local iron = require('iron')
local view = require('iron.view')

-- Only use my own Iron mappings
vim.g.iron_map_defaults=0
vim.g.iron_map_extended=0

iron.core.add_repl_definitions {
  markdown = {
    ipython = {
      command = {"ipython"}
    }
  },
  julia = {
    julia = {
      command = {"julia"}
    }
  }
}

iron.core.set_config {
  repl_open_cmd = view.openwin('botright 15 split'),
  preferred = {
    python = "ipython",
    markdown = "ipython",
    julia = "julia"
  }
}