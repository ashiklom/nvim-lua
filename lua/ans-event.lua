local utils = require('ans-utils')

utils.nvim_create_augroup('Spelling', {
  {"FileType", "text,tex,markdown,plaintex,gitcommit,org", "setlocal spell wrap"}
})

-- Auto-resize window splits when vim screen changes size
utils.nvim_create_augroup('Resize', {
  {"VimResized", "*", "wincmd ="}
})

-- Automatically change window directory on file enter
-- utils.nvim_create_augroup("Chdir", {
--   {"BufEnter", "*", [[if g:fix_wd == 0 | execute 'lcd '.v:lua.git_cwd() | endif]]}
-- })

