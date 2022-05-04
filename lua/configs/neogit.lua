local neogit = require('neogit')

vim.keymap.set('n', '<leader>gg', function() neogit.open({ kind="split"}) end, {silent=true})

neogit.setup{
  disable_commit_confirmation = true,
  mappings = {
    status = {
      ["F"] = "PullPopup",
      ["p"] = "PushPopup"
    }
  }
}
