local function bbind(mode, map, command)
  vim.api.nvim_buf_set_keymap(0, mode, map, command, {silent=true})
end

bbind("n", "<localleader>l", [[<Plug>(iron-send-line)]])
bbind("n", "<localleader>s", [[<Plug>(iron-send-motion)]])
bbind("n", "<localleader><CR>", [[<Plug>(iron-cr)]])
bbind("n", "<localleader>x", [[<Plug>(iron-interrupt)]])

bbind("n", "<localleader>rf", [[:IronRepl<CR>]])
bbind("n", "<localleader>rr", [[:IronRestart<CR>]])
bbind("n", "<localleader>rq", [[:IronSend! exit()<CR>:IronFocus<CR>:bd!<CR>]])

bbind("n", "<localleader>rp", [[:execute 'IronSend! print('.expand("<cword>").')'<CR>]])

bbind("v", "<localleader>ss", [[<Plug>(iron-visual-send)]])
