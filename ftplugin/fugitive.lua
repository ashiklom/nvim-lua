-- Magit mappings make a lot of sense.
-- Trying to reproduce them here.
-- https://magit.vc/manual/magit/
vim.keymap.set('n', 'bc', [[:Git checkout ]], {buffer=true})

vim.keymap.set('n', 'm', [[:Git merge ]], {buffer=true})

vim.keymap.set('n', 'pp', [[:Git push<CR>]], {buffer=true})
vim.keymap.set('n', 'pfp', [[:Git push --force-with-lease<CR>]], {buffer=true})
vim.keymap.set('n', 'pu', [[:Git push upstream<CR>]], {buffer=true})

vim.keymap.set('n', 'Fm', [[:Git pull<CR>]], {buffer=true})
vim.keymap.set('n', 'Fu', [[:Git pull upstream<CR>]], {buffer=true})

vim.keymap.set('n', 'q', [[:quit<CR>]], {buffer=true, silent=true})
