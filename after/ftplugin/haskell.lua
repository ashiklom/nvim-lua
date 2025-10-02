local utils = require('ans-utils')
utils.register_iron_keys('print %s')

-- local ht = require("haskell-tools")
--
-- local bufnr = vim.api.nvim_get_current_buf()
--
-- local opts = {noremap = true, silent = true, buffer = bufnr, }
--
-- vim.keymap.set('n', '<localleader>rf', function()
--   ht.repl.toggle(vim.api.nvim_buf_get_name(0))
-- end, opts)
--
-- vim.keymap.set('n', '<localleader>aa', htp.lsp.buf_eval_all, opts)
-- vim.keymap.set('n', '<localleader>rq', ht.repl.quit, opts)
--
-- vim.keymap.set('n', '<localleader>cl', vim.lsp.codelens.run, opts)
-- vim.keymap.set('n', '<localleader>K', ht.hoogle.hoogle_signature, opts)
