local neogit = require('neogit')

vim.keymap.set('n', '<leader>gg', neogit.open)

neogit.setup{
  disable_commit_confirmation = true,
  mappings = {
    status = {
      ["F"] = "PullPopup",
      ["p"] = "PushPopup"
    }
  },
  kind = "split_above",
  commit_popup = {kind = "split_above"}
}
