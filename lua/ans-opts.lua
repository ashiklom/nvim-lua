-- Settings
vim.cmd [[filetype plugin indent on]]
vim.cmd [[syntax enable]]

pcall(vim.cmd, [[colorscheme sonokai]])

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
vim.opt.listchars = "tab:>-,trail:-,nbsp:+"
-- vim.opt.wildignore:append({'*.o', '*.so', '*.html'})

vim.opt.formatoptions = 'cqwj'

-- Disable mouse
vim.opt.mouse = ''

-- vim.opt.isfname:remove('=')
-- Doesn't work for some reason; fall back on vim CMD
vim.cmd [[set isfname-==]]

if vim.g.neovide then
  vim.o.guifont="JuliaMono,Hack_Nerd_Font"
  vim.g.neovide_cursor_animation_length = 0
end

-- Stolen from TJ Devries:
-- https://github.com/tjdevries/config.nvim/blob/master/plugin/clipboard.lua
if vim.env.SSH_CONNECTION then
  local function vim_paste()
    local content = vim.fn.getreg('"')
    return vim.split(content, "\n")
  end
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*")
    },
    paste = {
      ["+"] = vim_paste,
      ["*"] = vim_paste
    }
  }
end
