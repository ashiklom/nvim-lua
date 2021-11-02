local tld = require('toggle_lsp_diagnostics')
tld.init()

local keymap = vim.api.nvim_set_keymap
keymap('n', '<leader>tld', [[<Plug>(toggle-lsp-diag)]], {silent=true})
