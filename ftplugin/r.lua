-- Indentation rules
vim.g.r_indent_align_args = 1
vim.g.r_indent_rstudio = 1
vim.api.nvim_buf_set_option(0, "tabstop", 2)

if packer_plugins['nvim-r'] then
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

  map_rcall_cword('n', '<localleader>rg', 'dplyr::glimpse')

-- require('cmp').setup.buffer { enabled = false }
-- map('i', "<C-Space>", "<C-x><C-o>")
else
  local iron = require('iron.core')

  local function bbind(mode, map, command)
    vim.keymap.set(mode, map, command, {silent=true, buffer=true})
  end

  local ctrlc = string.char(03)

  bbind("i", "<M-->", " <- ")
  bbind("i", "<M-m>", " %>%")

  bbind('n', '<localleader>rf', [[:IronRepl<CR>]])
  bbind('n', '<localleader>rr', iron.repl_restart)
  bbind('n', '<localleader>rq', iron.close_repl)

  bbind('n', '<localleader>l', iron.send_line)
  bbind('n', '<localleader>x', function() iron.send(nil, ctrlc) end)

  bbind('v', '<localleader>ss', iron.visual_send)

  bbind("n", "<localleader>rp", function()
    local cmd = string.format('print(%s)', vim.fn.expand('<cword>'))
    iron.send(nil, {cmd})
  end)

  bbind("n", "<localleader>rs", function()
    local cmd = string.format('str(%s)', vim.fn.expand('<cword>'))
    iron.send(nil, {cmd})
  end)

  -- Send paragraph
  bbind('n', '<localleader>pp', function()
    vim.api.nvim_feedkeys('m0', 'n', false)
    vim.api.nvim_feedkeys('vip', 'n', false)
    iron.visual_send()
    vim.api.nvim_feedkeys('`0', 'n', false)
  end)

end
