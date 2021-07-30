local execute = vim.api.nvim_command
local fn = vim.fn

-- Bootstrap packer.nvim
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
	execute 'packadd packer.nvim'
end

vim.cmd [[autocmd BufWritePost plugins.lua PackerCompile]]
require('plugins')

-- Load selected plugin configs
require('ans-compe')
require('ans-git')
require('ans-iron')
require('ans-jupytext')
require('ans-lsp')
require('ans-treesitter')

local utils = require('ans-utils')
local vimp = require('vimp')
local ans_tele = require('ans-telescope')
local tele = require('telescope')
local teleb = require('telescope.builtin')

-- Settings
vim.cmd [[filetype plugin indent on]]
vim.cmd [[syntax enable]]
vim.cmd [[colorscheme sonokai]]

local indent = 2

vim.opt.tabstop = indent
vim.opt.shiftwidth = 0
vim.opt.softtabstop = -1
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.copyindent = true
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.number = true

vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.hidden = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 2
vim.opt.swapfile = false
vim.opt.signcolumn = "yes"

vim.opt.completeopt:remove("preview")
-- vim.opt.wildignore:append({'*.o', '*.so', '*.html'})

-- vim.opt.isfname:remove('=')
-- Doesn't work for some reason; fall back on vim CMD
vim.cmd [[set isfname-==]]

vim.g.mapleader = ' '
vim.g.maplocalleader = ' m'

vimp.bind('i', 'jk', '<Esc>')
vimp.bind('n', 'Q', '<Nop>')
vimp.bind('n', {'silent'}, '<ESC>', [[:nohlsearch<CR>]])

-- Visual line navigation
vimp.bind('n', 'j', 'gj')
vimp.bind('n', 'k', 'gk')
vimp.bind('n', 'gj', 'j')
vimp.bind('n', 'gk', 'k')

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
vimp.bind('n', {'silent'}, '<leader>fn', function() teleb.file_browser({cwd="~/.deft"}) end)
vimp.bind('n', {'silent'}, '<leader>fp', [[:Files ~/.config/nvim<CR>]])
vimp.bind('n', {'silent'}, '<leader>bb', function() teleb.buffers() end)
vimp.bind('n', {'silent'}, '<leader>bk', [[:b#|bd#<CR>]])
vimp.bind('n', {'silent'}, '<leader>ht', function() teleb.help_tags() end)
vimp.bind('n', {'silent'}, '<leader>hk', function() teleb.keymaps() end)
vimp.bind('n', {'silent'}, '<leader>ss', function() teleb.current_buffer_fuzzy_find() end)
vimp.bind('n', {'silent'}, '<leader>sp', [[:Rg<CR>]])
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
vimp.rbind('n', '<leader>nf', ':Files ~/.deft<CR>')

-- Reload vimrc
vimp.bind('n', '<leader>%r', function()
  vimp.unmap_all()
  vim.cmd [[luafile ~/.config/nvim/init.lua]]
  print("Reloaded vimrc!")
end)

-- Completion mappings
local vopts = {"silent", "expr"}
vimp.bind("i", vopts, "<C-Space>", [[compe#complete()]])
-- NOTE: Can't use this b/c of interaction with `pears`. See lua/plugins.lua.
-- vimp.bind("i", vopts, "<CR>", [[compe#confirm('<CR>')]])

utils.nvim_create_augroup('Spelling', {
  {"FileType", "text,tex,markdown,plaintex,gitcommit", "setlocal spell wrap"}
})

-- Automatically change window directory on file enter
utils.nvim_create_augroup("Chdir", {
  {"BufEnter", "*", [[if g:fix_wd == 0 | execute 'lcd '.v:lua.git_cwd() | endif]]}
})

vim.cmd [[iab <expr> tdy strftime("%Y-%m-%d")]]

vimp.add_chord_cancellations('n', '<leader>')
