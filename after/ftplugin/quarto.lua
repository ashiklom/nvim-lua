local ok, otter = pcall(require, 'otter')
if ok then
  otter.activate()
end

vim.keymap.set("n", "<localleader>pr", [[:!quarto render "%"<CR>]])

-- Turn on wrapping by default
vim.opt_local.wrap = true

-- Abbrev to quickly insert reference via Telescope bibtex
vim.cmd([[inoreabbrev iref <ESC>:Telescope bibtex<CR>]])
