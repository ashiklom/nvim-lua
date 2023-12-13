local neogit = require('neogit')

vim.keymap.set('n', '<leader>gg', neogit.open)

neogit.setup{
  disable_commit_confirmation = true,
  mappings = {
    popup = {
      ["F"] = "PullPopup",
      ["p"] = "PushPopup"
    }
  },
  kind = "split_above",
  popup = {kind = "split_above"}
}
