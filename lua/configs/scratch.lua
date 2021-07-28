vim.api.nvim_set_keymap('n', '<leader>bx', [[:Scratch<CR>]], {silent=true, noremap=true})
vim.api.nvim_set_keymap('n', '<leader>bX', [[:Scratch!<CR>]], {silent=true, noremap=true})
vim.api.nvim_set_keymap('v', '<leader>bx', [[:ScratchSelection<CR>]], {silent=true, noremap=true})
vim.api.nvim_set_keymap('v', '<leader>bX', [[:ScratchSelection!<CR>]], {silent=true, noremap=true})
