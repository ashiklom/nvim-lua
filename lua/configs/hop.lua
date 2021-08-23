local hop = require('hop')
hop.setup{}

local keymap = vim.api.nvim_set_keymap
local opts = {silent=true, noremap=true}

keymap('', 'gsl', [[<cmd>HopLine<CR>]], opts)
keymap('', 'gsj', [[<cmd>HopLineAC<CR>]], opts)
keymap('', 'gsk', [[<cmd>HopLineBC<CR>]], opts)
keymap('', 'gsw', [[<cmd>HopWord<CR>]], opts)
keymap('', 'gsf', [[<cmd>HopChar1AC<CR>]], opts)
keymap('', 'gsF', [[<cmd>HopChar2AC<CR>]], opts)
keymap('', 'gss', [[<cmd>HopChar2<CR>]], opts)
keymap('', 'gs/', [[<cmd>HopPattern<CR>]], opts)
