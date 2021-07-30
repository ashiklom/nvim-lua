vim.g['mergetool_layout'] = 'mr'
vim.g['mergetool_prefer_revision'] = 'local'

vim.api.nvim_set_keymap('n', '<leader>xt', [[<Plug>(MergetoolToggle)]])
