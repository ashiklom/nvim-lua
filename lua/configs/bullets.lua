vim.api.nvim_set_keymap('i', '<M-CR>', '<C-O>:InsertNewBullet<CR>', {silent=true, noremap=true})
vim.api.nvim_set_keymap('n', '<C-C><C-C>', ':ToggleCheckbox<CR>', {silent=true, noremap=true})
