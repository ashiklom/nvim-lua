return {
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    dependencies = { "ibhagwan/fzf-lua" },
    --@module 'obsidian'
    --@type obsidian.config
    opts = {
      legacy_commands = false,
      ui = { enable = false },
      picker = { name = "fzf-lua" },
      -- note_id_func = require("obsidian.builtin").title_id,
      note_id_func = function(...) require("obsidian.builtin").title_id(...) end,
      workspaces = {
        {
          name = "default",
          path = "~/obsidian-notes",
        },
      },
    },
    keys = {
      { '<leader>vo', ':Obsidian quick_switch<CR>' }
    }
  },
}
