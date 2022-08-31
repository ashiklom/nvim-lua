local utils = require('ans-utils')

utils.augroup("Spelling", "Filetype", {
  pattern = {"text,tex,markdown,plaintex,gitcommit,org"},
  command = "setlocal spell wrap"
})

-- Auto-resize window splits when vim screen changes size
utils.augroup("Resize", "VimResized", {pattern="*", command="wincmd =" })

-- utils.augroup("Pandoc", {'BufNewFile', 'BufFilePre', 'BufRead'}, {
--   pattern = {"*.md"},
--   command = "set filetype=markdown.pandoc"
-- })
-- utils.augroup("Pandoc", "FileType", {
--   pattern = "telekasten", command = "set syntax=markdown.pandoc"
-- })

-- Automatically change window directory on file enter
-- utils.nvim_create_augroup("Chdir", {
--   {"BufEnter", "*", [[if g:fix_wd == 0 | execute 'lcd '.v:lua.git_cwd() | endif]]}
-- })

