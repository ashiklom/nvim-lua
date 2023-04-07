local gs = require('gitsigns')

gs.setup{
  on_attach = function()
    vim.keymap.set("n", "]h", gs.next_hunk, {desc="Next hunk"})
    vim.keymap.set("n", "[h", gs.prev_hunk, {desc="Previous hunk"})
    vim.keymap.set({"n", "v"}, "<leader>hh", gs.preview_hunk, {desc="Preview hunk"})
    vim.keymap.set({"n", "v"}, "<leader>hs", gs.stage_hunk, {desc="Stage hunk"})
    vim.keymap.set({"n", "v"}, "<leader>hx", gs.reset_hunk, {desc="Reset hunk"})
    vim.keymap.set({"n", "v"}, "<leader>hz", gs.undo_stage_hunk, {desc="Undo stage hunk"})
    vim.keymap.set("n", "<leader>hb", gs.blame_line, {desc="Blame line"})
  end
}
