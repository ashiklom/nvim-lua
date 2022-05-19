local function bbind(mode, map, command)
  vim.keymap.set(mode, map, command, {silent=true, buffer=true})
end

vim.g.markdown_folding = true
vim.opt_local.foldlevel = 20

-- -- Temporarily disabled; need to sort out issues with Iron config
-- bbind("n", "<localleader>l", [[<Plug>(iron-send-line)]])
-- bbind("n", "<localleader>s", [[<Plug>(iron-send-motion)]])
-- bbind("n", "<localleader><CR>", [[<Plug>(iron-cr)]])
-- bbind("n", "<localleader>x", [[<Plug>(iron-interrupt)]])

-- bbind("n", "<localleader>rf", [[:IronRepl<CR>]])
-- bbind("n", "<localleader>rr", [[:IronRestart<CR>]])
-- bbind("n", "<localleader>rq", [[:IronSend! exit()<CR>:IronFocus<CR>:bd!<CR>]])

-- bbind("v", "<localleader>ss", [[<Plug>(iron-visual-send)]])

-- Pandoc compilation bindings
bbind("n", "<localleader>ph", [[:!pandoc "%" -o "%:r.html"<CR>]])
bbind("n", "<localleader>pl", [[:!pandoc "%" -o "%:r.pdf"<CR>]])
bbind("n", "<localleader>pd", [[:!pandoc "%" -o "%:r.docx" --reference-doc=~/projects/other/pandoc-reference.docx<CR>]])
