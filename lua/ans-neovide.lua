-- Copy / paste with command
vim.keymap.set('v', '<D-c>', '"+y') -- Copy
vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
-- vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode
vim.keymap.set('i', '<D-v>', '<C-R>+') -- Paste insert mode

vim.o.guifont = "JetBrains Mono NL"

-- Disable animations
vim.g.neovide_cursor_animation_length = 0
vim.g.neovide_position_animation_length = 0
vim.g.neovide_scroll_animation_far_lines = 0
vim.g.neovide_scroll_animation_length = 0

-- Change display size
vim.g.neovide_scale_factor = 1.0
local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end

vim.keymap.set("n", "<D-=>", function()
    change_scale_factor(1.25)
end, {desc = "Neovide increase font size"})
vim.keymap.set("n", "<D-->", function()
    change_scale_factor(1/1.25)
end, {desc = "Neovide decrease font size"})
vim.keymap.set("n", "<D-0>", function()
  vim.g.neovide_scale_factor = 1.0
end, {desc = "Neovide reset font"})
