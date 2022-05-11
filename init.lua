-- Set this early, so it propagates properly
vim.g.mapleader = ' '
vim.g.maplocalleader = ' m'

require('plugins')
require('ans-keys')
require('ans-opts')
require('ans-event')

vim.cmd [[iab <expr> tdy strftime("%Y-%m-%d")]]

vim.cmd([[
if exists('g:vv')
  VVset fontfamily=JuliaMono,nonicons,Hack\ Nerd\ Font
endif
]])
