-- Install treesitter parsers (if they aren't already installed)
require("nvim-treesitter").install({ "r", "markdown", "rnoweb", "yaml" })

-- Indentation rules
vim.opt_local.tabstop = 2

-- Don't add space at end of `gw`
vim.opt_local.formatoptions:remove("w")

local function map(description, mode, lhs, rhs)
  local opts = { buffer = true, silent = true, desc = description }
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Unmap default RInsertPipe mapping -- it's annoying!
vim.keymap.del("i", "<localleader>,", { buffer = true })

map("R: Insert pipe", "i", "<M-.>", require("r.edit").pipe)

map("R: Insert roxygen comment", "i", "<C-'>", "#<C-v>'")

map("R-devtools: load_all", "n", "<localleader>vl", function()
  require("r.send").cmd("devtools::load_all('.')")
end)

map("R-devtools: document", "n", "<localleader>vd", function()
  require("r.send").cmd("devtools::document('.')")
end)

map("R-devtools: install", "n", "<localleader>vi", function()
  require("r.send").cmd("devtools::install('.')")
end)

map("R-devtools: test", "n", "<localleader>vt", function()
  require("r.send").cmd("devtools::test('.')")
end)

-- map_rcall('n', '<localleader>ro', 'httpgd::hgd(); hist(rnorm(100)); httpgd::hgd_browse()')

map("R: dplyr::glimpse", "n", "<localleader>rG", function()
  require("r.run").action("dplyr::glimpse")
end)
