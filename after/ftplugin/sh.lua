local utils = require('ans-utils')
utils.register_iron_keys('echo $%s')

-- Fix nvim-ception for man pages (triggered by `K`) by just calling :Man 
-- command directly. See GH issue #17.
vim.bo.keywordprg = ":Man"
