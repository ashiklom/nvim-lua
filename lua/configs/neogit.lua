local ng = require('neogit')

ng.setup{
  disable_commit_confirmation = true,
  mappings = {
    status = {
      ["F"] = "PullPopup",
      ["p"] = "PushPopup"
    }
  }
}
