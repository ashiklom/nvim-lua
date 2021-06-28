-- Indentation rules
vim.g.r_indent_align_args = 0
vim.api.nvim_buf_set_option(0, "cinoptions", "(0,W2,m1")
vim.api.nvim_buf_set_option(0, "tabstop", 2)

vim.g.R_nvim_wd = 1
vim.g.R_clear_line = 1
vim.g.R_setwidth = 2

local function map(mode, lhs, rhs)
  local opts = {silent=true, noremap=true}
  vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, opts)
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
map_rcall('n', '<localleader>vl', "devtools::load_all('.')")
map_rcall('n', '<localleader>vd', "devtools::document('.')")
map_rcall('n', '<localleader>vi', "devtools::install('.')")
map_rcall('n', '<localleader>vt', "devtools::test('.')")

map_rcall_cword('n', '<localleader>rg', 'dplyr::glimpse')
