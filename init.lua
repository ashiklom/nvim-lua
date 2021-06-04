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

local indent = 4

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

vim.opt.wildignore:append({'*.o', '*.so', '*.html'})
-- vim.opt.isfname:remove('=')
-- Doesn't work for some reason; fall back on vim CMD
vim.cmd [[set isfname-==]]

vim.g.mapleader = " "
vim.g.maplocalleader = " m"

local vimp = require('vimp')

vimp.bind('i', 'jk', '<Esc>')
vimp.bind('n', 'Q', '<Nop>')

vimp.bind('n', {'silent'}, '<leader>wj', [[:wincmd j<cr>]])
vimp.bind('n', {'silent'}, '<leader>wk', [[:wincmd k<cr>]])
vimp.bind('n', {'silent'}, '<leader>wl', [[:wincmd l<cr>]])
vimp.bind('n', {'silent'}, '<leader>wh', [[:wincmd h<cr>]])
vimp.bind('n', {'silent'}, '<leader>w-', [[:split<cr>]])
vimp.bind('n', {'silent'}, '<leader>w\\', [[:vsplit<cr>]])
vimp.bind('n', {'silent'}, '<leader>wd', [[:close<cr>]])

vimp.bind('n', {'silent'}, '<leader> ', function() require('telescope.builtin').find_files() end)
vimp.bind('n', {'silent'}, '<leader>ff', function() require('telescope.builtin').file_browser() end)
vimp.bind('n', {'silent'}, '<leader>bb', function() require('telescope.builtin').buffers() end)

vimp.bind('n', '<leader>%r', function()
    vimp.unmap_all()
    vim.cmd [[luafile ~/.config/nvim/init.lua]]
    print("Reloaded vimrc!")
end)

vimp.add_chord_cancellations('n', '<leader>')
