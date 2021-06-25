local execute = vim.api.nvim_command
local fn = vim.fn

-- Bootstrap packer.nvim
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
	execute 'packadd packer.nvim'
end

require('plugins')
vim.cmd [[autocmd BufWritePost plugins.lua PackerCompile]]

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

-- Load selected plugin configs
require('ans-iron')
require('ans-jupytext')
require('ans-lsp')
require('ans-treesitter')
require('ans-compe')

local vimp = require('vimp')
local ans_tele = require('ans-telescope')
local tele = require('telescope')
local teleb = require('telescope.builtin')

vimp.bind('i', 'jk', '<Esc>')
vimp.bind('n', 'Q', '<Nop>')

vimp.bind('n', {'silent'}, '<leader>wj', [[:wincmd j<cr>]])
vimp.bind('n', {'silent'}, '<leader>wk', [[:wincmd k<cr>]])
vimp.bind('n', {'silent'}, '<leader>wl', [[:wincmd l<cr>]])
vimp.bind('n', {'silent'}, '<leader>wh', [[:wincmd h<cr>]])
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

-- Easymotion
vimp.rbind('nvo', {'silent'}, 'gs', [[<Plug>(easymotion-prefix)]])
vimp.rbind('n', {'silent'}, 'gSj', [[<Plug>(easymotion-overwin-line)]])
vimp.rbind('n', {'silent'}, 'gSk', [[<Plug>(easymotion-overwin-line)]])
vimp.rbind('n', {'silent'}, 'gSf', [[<Plug>(easymotion-overwin-f)]])
vimp.rbind('n', {'silent'}, 'gSw', [[<Plug>(easymotion-overwin-w)]])

-- Exchange
vimp.rbind('v', {'silent'}, 'gx', [[<Plug>(Exchange)]])

local neogit = require('neogit')
vimp.bind('n', {'silent'}, '<leader>gg', function() neogit.open({ kind="split"}) end)

-- Change directory to file directory
vimp.bind('n', {'silent'}, '<leader>cd', [[:cd %:p:h<cr>]])

-- Reload vimrc
vimp.bind('n', '<leader>%r', function()
  vimp.unmap_all()
  vim.cmd [[luafile ~/.config/nvim/init.lua]]
  print("Reloaded vimrc!")
end)

vimp.add_chord_cancellations('n', '<leader>')
