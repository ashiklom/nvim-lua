local ng = require('neogit')

ng.setup{
  disable_commit_confirmation = true,
  use_magit_keybindings = true,
  mappings = {
    status = {
      -- ["F"] = "PullPopup",
      ["p"] = "PushPopup"
    }
  }
}
