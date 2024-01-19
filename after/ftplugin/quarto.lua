vim.keymap.set("n", "<localleader>pr", [[:!quarto render "%"<CR>]])

-- Abbrev to quickly insert reference via Telescope bibtex
vim.cmd([[inoreabbrev iref <ESC>:Telescope bibtex<CR>]])
