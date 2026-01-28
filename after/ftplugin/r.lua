-- Install treesitter parsers if not installed
vim.g.treesitter_checked_parsers = vim.g.treesitter_checked_parsers or {}

local required_parsers = { "r", "markdown", "rnoweb", "yaml" }
local parsers = require("nvim-treesitter.parsers")
local ts_install = require("nvim-treesitter.install")

for _, parser in ipairs(required_parsers) do
  if not vim.g.treesitter_checked_parsers[parser] then
    local parser_config = parsers.get_parser_configs()[parser]
    if parser_config and not parsers.has_parser(parser) then
      ts_install.ensure_installed(parser)
      vim.notify("Installing Tree-sitter parser for " .. parser, vim.log.levels.INFO)
    end
    vim.g.treesitter_checked_parsers[parser] = true
  end
end

-- Indentation rules
vim.opt_local.tabstop = 2

-- Don't add space at end of `gw`
vim.opt_local.formatoptions:remove('w')

local function map(mode, lhs, rhs)
  local opts = {buffer = true, silent=true}
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Unmap default RInsertPipe mapping -- it's annoying!
vim.keymap.del('i', '<localleader>,', {buffer = true})

map('i', "<M-.>", require('r.edit').pipe)
map('n', '<localleader>vl', function() require('r.send').cmd("devtools::load_all('.')") end)
map('n', '<localleader>vd', function() require('r.send').cmd("devtools::document('.')") end)
map('n', '<localleader>vi', function() require('r.send').cmd("devtools::install('.')") end)
map('n', '<localleader>vt', function() require('r.send').cmd("devtools::test('.')") end)

-- map_rcall('n', '<localleader>ro', 'httpgd::hgd(); hist(rnorm(100)); httpgd::hgd_browse()')

map('n', '<localleader>rG', function() require('r.run').action('dplyr::glimpse') end)
