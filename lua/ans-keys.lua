local tele = require('telescope')
local telef = tele.extensions.file_browser
local teleb = require('telescope.builtin')
local utils = require('ans-utils')

vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('n', 'Q', '<Nop>')
vim.keymap.set('n', '<ESC>', [[:nohlsearch<CR>]], {silent=true})

-- Visual line navigation
vim.keymap.set({'n', 'v'}, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set({'n', 'v'}, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({'n', 'v'}, 'gk', "v:count == 0 ? 'k' : 'gk'", { expr = true, silent = true })
vim.keymap.set({'n', 'v'}, 'gj', "v:count == 0 ? 'j' : 'gj'", { expr = true, silent = true })

-- Most recent buffer
vim.keymap.set('n', 'gb', '<C-^>')

-- Toggle wrap long lines
vim.keymap.set('n', '<leader>$', [[:setlocal wrap!<CR>]], {silent=true})

local winkeys = "jklh=xrRT"
for i = 1, #winkeys do
  local key = winkeys:sub(i,i)
  vim.keymap.set('n', '<leader>w'..key, string.format([[:wincmd %s<cr>]], key), {silent=true})
end

vim.keymap.set('n', '<leader>ww', [[:wincmd p<cr>]], {silent=true})
vim.keymap.set('n', '<leader>w+', [[:5 wincmd +<cr>]], {silent=true})
vim.keymap.set('n', '<leader>w_', [[:5 wincmd -<cr>]], {silent=true})
vim.keymap.set('n', '<leader>w-', [[:split<cr>]], {silent=true})
vim.keymap.set('n', '<leader>w\\', [[:vsplit<cr>]], {silent=true})
vim.keymap.set('n', '<leader>wd', [[:close<cr>]], {silent=true})
vim.keymap.set('n', '<leader>wo', [[:Windows<CR>]], {silent=true})

vim.keymap.set('n', '<leader>fs', [[:write<cr>]], {silent=true})
vim.keymap.set('n', '<leader>fR', [[:Rename <C-r>=expand('%:t')<cr>]])
vim.keymap.set('n', '<leader>fK', [[:call delete(expand('%')) | bdelete!<cr>]])
vim.cmd([[cnoreabbrev W w]])

vim.keymap.set('n', 'z.', [[:<C-u>normal! zszH<CR>]], {silent=true})

-- Telescope mappings
vim.keymap.set('n', '<leader> ', teleb.find_files)
vim.keymap.set('n', '<leader>ff', telef.file_browser)
vim.keymap.set('n', '<leader>fF', function() telef.file_browser{hidden=true, respect_gitignore=false} end)
vim.keymap.set('n', '<leader>f~', function() telef.file_browser{cwd='~'} end)
vim.keymap.set('n', '<leader>fc', function() teleb.find_files{cwd="~/.config/nvim"}end)
vim.keymap.set('n', '<leader>fp', function() teleb.find_files{cwd="~/.local/share/nvim/site/pack/packer/"}end)
vim.keymap.set('n', '<leader>f?', teleb.oldfiles)
vim.keymap.set('n', '<leader>bb', teleb.buffers)
vim.keymap.set('n', '<leader>bk', [[:b#|bd#<CR>]], {silent=true})
vim.keymap.set('n', '<leader>ht', teleb.help_tags)
vim.keymap.set('n', '<leader>hk', teleb.keymaps)
vim.keymap.set('n', '<leader>ss', teleb.current_buffer_fuzzy_find)
vim.keymap.set('n', '<leader>sd', teleb.grep_string)
vim.keymap.set('n', '<leader>sp', teleb.live_grep)
vim.keymap.set('n', '<leader>s"', teleb.registers)
vim.keymap.set('n', 'z=', teleb.spell_suggest)

vim.keymap.set('n', '<leader>po', tele.extensions.project.project)
vim.keymap.set('n', '<leader>pL', [[:e ~/.local/share/nvim/telescope-projects.txt<cr>]], {silent=true})

-- Exchange
vim.keymap.set('v', 'gx', [[<Plug>(Exchange)]], {silent=true})

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

-- Reload vimrc
vim.keymap.set('n', '<leader>%r', utils.reload_vimrc, {silent=true})
vim.keymap.set('n', '<leader>%s', [[:PackerSync<CR>]], {silent=true})
vim.keymap.set('n', '<leader>%c', [[:PackerCompile<CR>]], {silent=true})

vim.keymap.set('n', '<leader>^', [[:setlocal list!<CR>]])

vim.cmd [[iab <expr> tdy strftime("%Y-%m-%d")]]
