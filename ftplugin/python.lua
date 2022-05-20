vim.g.neoterm_size = 10
vim.g.neoterm_default_mod = 'botright'
vim.g.neoterm_repl_enable_ipython_paste_magic = true

vim.keymap.set('n', '<localleader>rt', function()
  vim.g.neoterm_repl_enable_ipython_paste_magic = not vim.g.neoterm_repl_enable_ipython_paste_magic
  print(string.format(
    "IPython paste magic: %s",
    tostring(vim.g.neoterm_repl_enable_ipython_paste_magic)
  ))
end, {silent = true})

vim.keymap.set('n', '<localleader>rf', [[:Tnew<CR>]], {silent=true})
vim.keymap.set('n', '<localleader>rq', [[:Tclose!<CR>]], {silent=true})

vim.keymap.set('n', '<localleader>l', [[:TREPLSendLine<CR>]], {silent=true})
vim.keymap.set('n', '<localleader>d', [[:TREPLSendLine<CR>:<C-u>call search('^.\+')<CR>]], {silent=true})

vim.keymap.set('n', '<localleader>pp', [[m0<Plug>(neoterm-repl-send)ip`0]], {silent=true})
vim.keymap.set('n', '<localleader>pd', [[<Plug>(neoterm-repl-send)ip}:<C-u>call search('^.\+')<CR>]], {silent=true})

vim.keymap.set('n', '<localleader>aa', [[:TREPLSendFile<CR>]], {silent=true})

vim.keymap.set('n', '<localleader>rp', [[:Texec print(<C-r><C-w>)<CR>]], {silent=true})

vim.keymap.set('v', '<localleader>ss', [[:TREPLSendSelection<CR>]], {silent=true})
