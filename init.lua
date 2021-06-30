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

local winkeys = {"j","k","l","h","="}
for _, key in ipairs(winkeys) do
  vimp.bind('n', {'silent'}, '<leader>w'..key, string.format([[:wincmd %s<cr>]], key))
end

vimp.bind('n', {'silent'}, '<leader>ww', [[:wincmd p<cr>]])
vimp.bind('n', {'silent'}, '<leader>w+', [[:5 wincmd +<cr>]])
vimp.bind('n', {'silent'}, '<leader>w_', [[:5 wincmd -<cr>]])
vimp.bind('n', {'silent'}, '<leader>w-', [[:split<cr>]])
vimp.bind('n', {'silent'}, '<leader>w\\', [[:vsplit<cr>]])
vimp.bind('n', {'silent'}, '<leader>wd', [[:close<cr>]])

vimp.bind('n', {'silent'}, '<leader>fs', [[:w<cr>]])

vimp.bind('n', {'silent'}, 'z.', [[:<C-u>normal! zszH<CR>]])

-- Telescope mappings
vimp.bind('n', {'silent'}, '<leader> ', function() teleb.find_files() end)
-- vimp.bind('n', {'silent'}, '<leader>ff', function() require('telescope.builtin').file_browser({hidden=true}) end)
vimp.bind('n', {'silent'}, '<leader>ff', function() ans_tele.file_browser_cwd() end)
-- vimp.bind('n', {'silent'}, '<leader>f`', function() require('telescope.builtin').file_browser({cwd="~", hidden=true}) end)
vimp.bind('n', {'silent'}, '<leader>f`', function() ans_tele.file_browser_home() end)
vimp.bind('n', {'silent'}, '<leader>bb', function() teleb.buffers() end)
vimp.bind('n', {'silent'}, '<leader>bk', [[:b#|bd#<CR>]])
vimp.bind('n', {'silent'}, '<leader>ht', function() teleb.help_tags() end)
vimp.bind('n', {'silent'}, '<leader>ss', function() teleb.current_buffer_fuzzy_find() end)
vimp.bind('n', {'silent'}, '<leader>sp', function() teleb.live_grep() end)
vimp.bind('n', {'silent'}, '<leader>po', function() tele.extensions.project.project{} end)
vimp.bind('n', {'silent'}, '<leader>pL', [[:e ~/.local/share/nvim/telescope-projects.txt<cr>]])
vimp.bind('n', {'silent'}, 'z=', function() teleb.spell_suggest() end)

-- Easymotion
-- vimp.rbind('nvo', {'silent'}, 'gs', [[<Plug>(easymotion-prefix)]])
-- vimp.rbind('n', {'silent'}, 'gSj', [[<Plug>(easymotion-overwin-line)]])
-- vimp.rbind('n', {'silent'}, 'gSk', [[<Plug>(easymotion-overwin-line)]])
-- vimp.rbind('n', {'silent'}, 'gSf', [[<Plug>(easymotion-overwin-f)]])
-- vimp.rbind('n', {'silent'}, 'gSw', [[<Plug>(easymotion-overwin-w)]])

-- Exchange
vimp.rbind('v', {'silent'}, 'gx', [[<Plug>(Exchange)]])

local neogit = require('neogit')
vimp.bind('n', {'silent'}, '<leader>gg', function() neogit.open({ kind="split"}) end)

-- Change directory to file directory
vimp.bind('n', {'silent'}, '<leader>cd', [[:cd %:p:h<cr>]])

-- Delete trailing whitespace
vimp.bind('v', {'silent'}, '<leader>cw', [[:s/\s\+$//ge<CR>]])
vimp.bind('n', {'silent'}, '<leader>cw', [[:.s/\s\+$//ge<CR>]])  -- Current line only
vimp.bind('n', {'silent'}, '<leader>cW', [[:%s/\s\+$//ge<CR>]])  -- Entire file

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

vimp.add_chord_cancellations('n', '<leader>')
