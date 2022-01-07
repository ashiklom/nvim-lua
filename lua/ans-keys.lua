local vimp = require('vimp')
local ans_tele = require('ans-telescope')
local tele = require('telescope')
local telef = tele.extensions.file_browser
local teleb = require('telescope.builtin')
local utils = require('ans-utils')

vimp.bind('i', 'jk', '<Esc>')
vimp.bind('n', 'Q', '<Nop>')
vimp.bind('n', {'silent'}, '<ESC>', [[:nohlsearch<CR>]])

-- Visual line navigation
vimp.bind('nv', 'j', 'gj')
vimp.bind('nv', 'k', 'gk')
vimp.bind('nv', 'gj', 'j')
vimp.bind('nv', 'gk', 'k')

-- Most recent buffer
vimp.bind('n', 'gb', '<C-^>')

-- Toggle wrap long lines
vimp.bind('n', {'silent'}, '<leader>$', [[:setlocal wrap!<CR>]])

local winkeys = "jklh=xrRT"
for i = 1, #winkeys do
  local key = winkeys:sub(i,i)
  vimp.bind('n', {'silent'}, '<leader>w'..key, string.format([[:wincmd %s<cr>]], key))
end

vimp.bind('n', {'silent'}, '<leader>ww', [[:wincmd p<cr>]])
vimp.bind('n', {'silent'}, '<leader>w+', [[:5 wincmd +<cr>]])
vimp.bind('n', {'silent'}, '<leader>w_', [[:5 wincmd -<cr>]])
vimp.bind('n', {'silent'}, '<leader>w-', [[:split<cr>]])
vimp.bind('n', {'silent'}, '<leader>w\\', [[:vsplit<cr>]])
vimp.bind('n', {'silent'}, '<leader>wd', [[:close<cr>]])
vimp.bind('n', {'silent'}, '<leader>wo', [[:Windows<CR>]])

vimp.bind('n', {'silent'}, '<leader>fs', [[:write<cr>]])
vimp.bind('n', '<leader>fR', [[:Rename ]])
vim.cmd([[cnoreabbrev W w]])

vimp.bind('n', {'silent'}, 'z.', [[:<C-u>normal! zszH<CR>]])

-- Telescope mappings
vimp.bind('n', {'silent'}, '<leader> ', [[:Files<CR>]])
vimp.bind('n', {'silent'}, '<leader>ff', function() ans_tele.file_browser_cwd() end)
vimp.bind('n', {'silent'}, '<leader>fF', [[:Files ~<CR>]])
vimp.bind('n', {'silent'}, '<leader>fn', function() telef.file_browser({cwd="~/.deft"}) end)
vimp.bind('n', {'silent'}, '<leader>fp', [[:Files ~/.config/nvim<CR>]])
vimp.bind('n', {'silent'}, '<leader>bb', function() teleb.buffers() end)
vimp.bind('n', {'silent'}, '<leader>bk', [[:b#|bd#<CR>]])
vimp.bind('n', {'silent'}, '<leader>ht', function() teleb.help_tags() end)
vimp.bind('n', {'silent'}, '<leader>hk', function() teleb.keymaps() end)
vimp.bind('n', {'silent'}, '<leader>ss', function() teleb.current_buffer_fuzzy_find() end)
vimp.bind('n', {'silent'}, '<leader>sp', [[:Rg<CR>]])
vimp.bind('n', {'silent'}, '<leader>s"', function() teleb.registers() end)
vimp.bind('n', {'silent'}, '<leader>po', function() tele.extensions.project.project{} end)
vimp.bind('n', {'silent'}, '<leader>pL', [[:e ~/.local/share/nvim/telescope-projects.txt<cr>]])
vimp.bind('n', {'silent'}, 'z=', function() teleb.spell_suggest() end)

-- Exchange
vimp.rbind('v', {'silent'}, 'gx', [[<Plug>(Exchange)]])

local neogit = require('neogit')
vimp.bind('n', {'silent'}, '<leader>gg', function() neogit.open({ kind="split"}) end)

-- Change directory to file directory
vim.g["fix_wd"] = false
vimp.bind('n', {'silent'}, '<leader>cd', function()
  vim.g["fix_wd"] = true
  vim.cmd(string.format("cd %s", utils.git_cwd()))
end)
vimp.bind('n', {'silent'}, '<leader>cD', function()
  vim.g["fix_wd"] = true
  vim.cmd(string.format("cd %s", utils.buf_cwd()))
end)
vimp.bind('n', {'silent'}, '<leader>c0', function() vim.g["fix_wd"] = not vim.g["fix_wd"] end)

-- Delete trailing whitespace
vimp.bind('v', {'silent'}, '<leader>cw', [[:s/\s\+$//ge<CR>]])
vimp.bind('n', {'silent'}, '<leader>cw', [[:.s/\s\+$//ge<CR>]])  -- Current line only
vimp.bind('n', {'silent'}, '<leader>cW', [[:%s/\s\+$//ge<CR>]])  -- Entire file

vimp.rbind('n', {'silent'}, '<leader>nd', ':NV<CR>')
vimp.rbind('n', '<leader>nf', ':Files ~/notes<CR>')

-- Reload vimrc
vimp.bind('n', '<leader>%r', function() utils.reload_vimrc() end)
vimp.bind('n', {'silent'}, '<leader>%s', [[:PackerSync<CR>]])
vimp.bind('n', {'silent'}, '<leader>%c', [[:PackerCompile<CR>]])

vimp.bind('n', '<leader>^', [[:setlocal list!]])

vimp.add_chord_cancellations('n', '<leader>')
