local ok, otter = pcall(require, 'otter')
if ok then
  otter.activate()
end

vim.keymap.set("n", "<localleader>pr", [[:!quarto render "%"<CR>]])

-- Unmap default RInsertPipe mapping -- it's annoying!
vim.keymap.del('i', '<localleader>,', {buffer = true})

vim.keymap.set("i", "<M-.>", require('r.edit').pipe, {buffer=true, desc="R: Insert pipe"})

-- Turn on wrapping by default
vim.opt_local.wrap = true

-- Abbrev to quickly insert reference via Telescope bibtex
vim.cmd([[inoreabbrev iref <ESC>:Telescope bibtex<CR>]])
