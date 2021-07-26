vim.api.nvim_set_var('splitjoin_split_mapping', '')
vim.api.nvim_set_var('splitjoin_join_mapping', '')
local opts = {silent=true, noremap=true}
vim.api.nvim_set_keymap('n', 'g[', [[:SplitjoinSplit<CR>]], opts)
vim.api.nvim_set_keymap('n', 'g]', [[:SplitjoinJoin<CR>]], opts)
