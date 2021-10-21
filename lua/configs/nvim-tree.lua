require('nvim-tree').setup{}

vim.api.nvim_set_keymap('n', '<leader>fo', [[<Cmd>NvimTreeToggle<CR>]], {silent=true, noremap=true})
vim.api.nvim_set_keymap('n', '<leader>fr', [[<Cmd>NvimTreeRefresh<CR>]], {silent=true, noremap=true})
