local gs = require('gitsigns')

gs.setup{
  on_attach = function()
    vim.keymap.set("n", "]h", gs.next_hunk)
    vim.keymap.set("n", "[h", gs.prev_hunk)
    vim.keymap.set({"n", "v"}, "<leader>hh", gs.preview_hunk)
    vim.keymap.set({"n", "v"}, "<leader>hs", gs.stage_hunk)
    vim.keymap.set({"n", "v"}, "<leader>hx", gs.reset_hunk)
    vim.keymap.set({"n", "v"}, "<leader>hz", gs.undo_stage_hunk)
    vim.keymap.set("n", "<leader>hb", gs.blame_line)
  end
}
