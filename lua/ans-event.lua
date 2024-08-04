local function augroup(name)
  return vim.api.nvim_create_augroup("ansauto_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("Filetype", {
  group = augroup("spelling"),
  pattern = {"text,tex,markdown,plaintex,gitcommit,org"},
  command = "setlocal spell wrap"
})

-- Auto-resize window splits when vim screen changes size
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup("resize"),
  pattern="*",
  command="wincmd ="
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup('close_with_q'),
  pattern = {
    "help",
    "lspinfo",
    "notify",
    "qf",
    "checkhealth"
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", {
      buffer = event.buf,
      silent = true,
      desc = "Quit buffer"
    })
  end
})

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

