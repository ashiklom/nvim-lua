require('neorg').setup {
  -- Tell Neorg what modules to load
  load = {
    ["core.defaults"] = {}, -- Load all the default modules
    ["core.norg.dirman"] = { -- Manage your directories with Neorg
      config = {
        workspaces = {
          test_workspace = "~/scratch/neorg"
        }
      }
    },
    ["core.gtd.base"] = { config = {
      workspace = "test_workspace"
    }},
    ["core.keybinds"] = { config = {
      default_keybinds = true
    }}
    -- ["core.norg.concealer"] = {}, -- Allows for use of icons
  }
}
