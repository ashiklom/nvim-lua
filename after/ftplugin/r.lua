-- Indentation rules
vim.g.r_indent_align_args = 1
vim.g.r_indent_rstudio = 1
vim.api.nvim_buf_set_option(0, "tabstop", 2)

-- Nvim-R configuration
vim.g.R_nvim_wd = 1
vim.g.R_clear_line = 1
vim.g.R_setwidth = 2

local function map(mode, lhs, rhs)
  local opts = {buffer = true, silent=true}
  vim.keymap.set(mode, lhs, rhs, opts)
end

local function map_rcall(mode, lhs, rcall)
  local rhs = string.format([[:call g:SendCmdToR("%s")<CR>]], rcall)
  map(mode, lhs, rhs)
end

local function map_rcall_cword(mode, lhs, rcall)
  local rhs = string.format([[:call g:SendCmdToR("%s(".expand("<cword>").")")<CR>]], rcall)
  map(mode, lhs, rhs)
end

vim.g.R_assign_map = '<M-->'

map('i', "<M-m>", " %>%")
map('i', "<M-.>", " |>")
map('n', 'K', [[:call RAction('help')<CR>]])
map_rcall('n', '<localleader>vl', "devtools::load_all('.')")
map_rcall('n', '<localleader>vd', "devtools::document('.')")
map_rcall('n', '<localleader>vi', "devtools::install('.')")
map_rcall('n', '<localleader>vt', "devtools::test('.')")

map_rcall('n', '<localleader>ro', 'httpgd::hgd(); hist(rnorm(100)); httpgd::hgd_browse()')

map_rcall_cword('n', '<localleader>rg', 'dplyr::glimpse')
map_rcall_cword('n', '<localleader>rs', 'str')
map_rcall_cword('n', '<localleader>rS', 'summary')
