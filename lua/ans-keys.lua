local utils = require('ans-utils')

vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('n', 'Q', '<Nop>')
vim.keymap.set('n', '<ESC>', [[:nohlsearch<CR>]], {silent=true})

-- Visual line navigation
vim.keymap.set({'n', 'v'}, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set({'n', 'v'}, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({'n', 'v'}, 'gk', "v:count == 0 ? 'k' : 'gk'", { expr = true, silent = true })
vim.keymap.set({'n', 'v'}, 'gj', "v:count == 0 ? 'j' : 'gj'", { expr = true, silent = true })

-- Buffer navigation
vim.keymap.set('n', ']b', ':bnext<CR>', {desc = "Next buffer", silent = true})
vim.keymap.set('n', '[b', ':bprevious<CR>', {desc = "Previous buffer", silent = true})
vim.keymap.set('n', 'gb', '<C-^>', {desc = "Most recent buffer"})

-- Quickfix
vim.keymap.set('n', '<leader>xq', vim.cmd.copen, {desc = "Quickfix open"})
vim.keymap.set('n', ']q', function() pcall(vim.cmd.cnext) end, {desc = "Next quickfix"})
vim.keymap.set('n', '[q', function() pcall(vim.cmd.cprev) end, {desc = "Previous quickfix"})

-- Diagnostics
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {desc = "Next diagnostic"})
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {desc = "Previous diagnostic"})
vim.keymap.set('n', ']e', function() vim.diagnostic.goto_next({severity = "ERROR"}) end, {desc = "Next error"})
vim.keymap.set('n', '[e', function() vim.diagnostic.goto_prev({severity = "ERROR"}) end, {desc = "Previous error"})
vim.keymap.set('n', ']E', function() vim.diagnostic.goto_next({severity = "WARN"}) end, {desc = "Next warning"})
vim.keymap.set('n', '[E', function() vim.diagnostic.goto_prev({severity = "WARN"}) end, {desc = "Previous warning"})
vim.keymap.set('n', '<leader>?', vim.diagnostic.open_float, {desc = "Current diagnostic"})

-- Open current file in system editor
vim.keymap.set('n', 'g<CR>', [[:!open <cWORD><CR>]], {silent=true})
vim.keymap.set('v', 'g<CR>', [[:w !xargs -0 open<CR>]], {silent=true})

-- Toggle wrap long lines
vim.keymap.set('n', '<leader>$', [[:setlocal wrap!<CR>]], {silent=true})

-- Terminal -- escpae with <esc><esc>
vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("ansauto_esc2", {clear = true}),
  pattern = {"term://*"},
  callback = function()
    vim.keymap.set('t', '<esc><esc>', [[<C-\><C-n>]], {buffer=true, nowait=true})
  end
})

-- ...except for these filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("ansauto_noesc2", {clear = true}),
  pattern = {"fzf"},
  callback = function()
    vim.keymap.del('t', '<esc><esc>', {buffer=true})
  end
})

vim.keymap.set('n', '<leader>wf', function() vim.cmd.wincmd("f") end, {desc = "Open file under cursor in new window"})
vim.keymap.set('n', '<leader>wF', function() vim.cmd.wincmd("F") end, {desc = "Open file (with line) under cursor in new window"})
vim.keymap.set('n', '<leader>w=', function() vim.cmd.wincmd("=") end, {desc = "Equalize window sizes"})
vim.keymap.set('n', '<leader>wr', function() vim.cmd.wincmd("r") end, {desc = "Rotate windows down"})
vim.keymap.set('n', '<leader>wR', function() vim.cmd.wincmd("R") end, {desc = "Rotate windows up"})
vim.keymap.set('n', '<leader>wT', function() vim.cmd.wincmd("T") end, {desc = "Move window to new tab"})

vim.keymap.set('n', '<leader>w-', function() vim.cmd.split() end, {desc = "Split window down"})
vim.keymap.set('n', '<leader>w\\',function() vim.cmd.vsplit() end, {desc = "Split window right"})
vim.keymap.set('n', '<leader>wd', function() vim.cmd.close() end, {desc = "Close window"})

vim.keymap.set('n', '<leader>fs', function() vim.cmd.write() end, {silent=true, desc="Save file"})
vim.keymap.set('n', '<leader>fK', [[:call delete(expand('%')) | bdelete!<cr>]], {desc="Delete buffer and file"})
vim.cmd([[cnoreabbrev W w]])

vim.keymap.set('n', 'z.', [[:<C-u>normal! zszH<CR>]], {silent=true})

-- Telescope mappings
local tele_ok, tele = pcall(require, 'telescope')
if tele_ok then
  vim.keymap.set('n', '<leader>po', tele.extensions.project.project, {desc="Telescope project"})
  vim.keymap.set('n', '<leader>pL', [[:e ~/.local/share/nvim/telescope-projects.txt<cr>]], {silent=true, desc="Edit projects file"})
end

-- Change directory to file directory
vim.keymap.set('n', '<leader>cd', function()
  local cmd = string.format("cd %s", utils.git_cwd())
  vim.cmd(cmd)
  print(cmd)
end)
vim.keymap.set('n', '<leader>cD', function()
  local cmd = string.format("cd %s", utils.buf_cwd())
  vim.cmd(cmd)
  print(cmd)
end)

-- Delete trailing whitespace
vim.keymap.set('v', '<leader>cw', [[:s/\s\+$//ge<CR>]], {silent=true})
vim.keymap.set('n', '<leader>cw', [[:.s/\s\+$//ge<CR>]], {silent=true})  -- Current line only
vim.keymap.set('n', '<leader>cW', [[:%s/\s\+$//ge<CR>]], {silent=true})  -- Entire file

-- Toggle autoformat
vim.keymap.set('n', '<leader>ga',
[[:if &fo=~'a' | setlocal fo-=a | echo "Autoformat disabled" | else | setlocal fo+=a | echo "Autoformat enabled" | endif <CR>]]
)

vim.keymap.set('n', '<leader>^', [[:setlocal list!<CR>]], {silent=true})

vim.cmd [[iab <expr> tdy strftime("%Y-%m-%d")]]
vim.cmd [[iab <expr> tstamp strftime("%Y-%m-%d %H:%M")]]
