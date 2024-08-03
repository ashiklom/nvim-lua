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

-- Open current file
vim.keymap.set('n', 'g<CR>', [[:!open <cWORD><CR>]], {silent=true})
vim.keymap.set('v', 'g<CR>', [[:w !xargs -0 open<CR>]], {silent=true})
-- vim.keymap.set('v', 'g<CR>', function()
--   local path = require('plenary.path')
--   local cword = vim.fn.expand('<cWORD>')
--   print(vim.inspect(cword))
--   local abspath = path:new(cword):expand()
--   print(vim.inspect(abspath))
--   -- vim.fn.system("open " .. abspath)
-- end)

-- Toggle wrap long lines
vim.keymap.set('n', '<leader>$', [[:setlocal wrap!<CR>]], {silent=true})

local winkeys = "jklh=xrRTJKLH"
for i = 1, #winkeys do
  local key = winkeys:sub(i,i)
  vim.keymap.set('n', '<leader>w'..key, string.format([[:wincmd %s<cr>]], key), {silent=true})
end

vim.keymap.set('n', '<leader>ww', [[:wincmd p<cr>]], {silent=true})
vim.keymap.set('n', '<leader>w+', [[:5 wincmd +<cr>]], {silent=true})
vim.keymap.set('n', '<leader>w_', [[:5 wincmd -<cr>]], {silent=true})
vim.keymap.set('n', '<leader>w]', [[:vertical resize +5<cr>]], {silent=true})
vim.keymap.set('n', '<leader>w[', [[:vertical resize -5<cr>]], {silent=true})
vim.keymap.set('n', '<leader>w-', [[:split<cr>]], {silent=true})
vim.keymap.set('n', '<leader>w\\', [[:vsplit<cr>]], {silent=true})
vim.keymap.set('n', '<leader>wd', [[:close<cr>]], {silent=true})
vim.keymap.set('n', '<leader>wo', [[:Windows<CR>]], {silent=true})

vim.keymap.set('n', '<leader>fo', [[:edit %:h<CR>]], {silent=true, desc="Open file directory"})
vim.keymap.set('n', '<leader>fO', [[:edit .<CR>]], {silent=true, desc="Open working directory"})
vim.keymap.set('n', '<leader>fs', [[:write<cr>]], {silent=true, desc="Save"})
vim.keymap.set('n', '<leader>fR', [[:Rename <C-r>=expand('%:t')<cr>]], {desc="Rename current buffer"})
vim.keymap.set('n', '<leader>fK', [[:call delete(expand('%')) | bdelete!<cr>]], {desc="Delete buffer and file"})
vim.cmd([[cnoreabbrev W w]])

vim.keymap.set('n', 'z.', [[:<C-u>normal! zszH<CR>]], {silent=true})

-- Telescope mappings
local tele_ok, tele = pcall(require, 'telescope')
if tele_ok then
  local telef = tele.extensions.file_browser
  local teleb = require('telescope.builtin')
  vim.keymap.set(
    'n',
    '<leader> ',
    function() teleb.find_files{hidden=true} end,
    {desc="Telescope find files"}
  )
  vim.keymap.set(
    'n',
    '<leader>ff',
    function() telef.file_browser{ hidden=true, no_ignore=true } end,
    {desc="Telescope browse all files"}
  )
  vim.keymap.set('n', '<leader>fr', teleb.oldfiles, {desc="Telescope recent files"})
  vim.keymap.set('n', '<leader>bb', teleb.buffers, {desc="Telescope buffers"})
  vim.keymap.set('n', '<leader>bk', [[:bp|bd #<CR>]], {silent=true, desc="Delete buffer"})
  vim.keymap.set('n', '<leader>ht', teleb.help_tags, {desc="Telescope help tags"})
  vim.keymap.set('n', '<leader>hk', teleb.keymaps, {desc="Telescope keymaps"})
  vim.keymap.set('n', '<leader>ss', teleb.current_buffer_fuzzy_find, {desc="Telescope search buffer"})
  vim.keymap.set('n', '<leader>sd', teleb.grep_string, {desc="Telescope search current string"})
  -- vim.keymap.set('n', '<leader>sp', teleb.live_grep, {desc="Telescope search project"})
  -- vim.keymap.set('n', '<leader>sp', [[:RG<CR>]], {desc="Telescope search project"})
  vim.keymap.set('n', '<leader>/', [[:FzfLua live_grep<CR>]], {desc="Search project"})
  vim.keymap.set('n', '<leader>:', [[:FzfLua command_history<CR>]], {desc="Command history"})
  vim.keymap.set('n', '<leader>s"', teleb.registers, {desc="Telescope registers"})
  vim.keymap.set('n', 'z=', teleb.spell_suggest, {desc="Telescope spelling"})

  vim.keymap.set('n', '<leader>po', tele.extensions.project.project, {desc="Telescope project"})
  vim.keymap.set('n', '<leader>pL', [[:e ~/.local/share/nvim/telescope-projects.txt<cr>]], {silent=true, desc="Edit projects file"})
end

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

-- Toggle autoformat
vim.keymap.set('n', '<leader>ga',
[[:if &fo=~'a' | setlocal fo-=a | echo "Autoformat disabled" | else | setlocal fo+=a | echo "Autoformat enabled" | endif <CR>]]
)

-- Reload vimrc
vim.keymap.set('n', '<leader>%r', utils.reload_vimrc, {silent=true})

vim.keymap.set('n', '<leader>^', [[:setlocal list!<CR>]])

vim.cmd [[iab <expr> tdy strftime("%Y-%m-%d")]]
vim.cmd [[iab <expr> tstamp strftime("%Y-%m-%d %H:%M")]]
