return {
  {
    "stevearc/overseer.nvim",
    ---@module 'overseer'
    ---@type overseer.SetupOpts
    opts = {},
    config = function ()
      local ovs = require('overseer')
      vim.keymap.set("n", "<leader>ot", function() ovs.toggle() end, {desc = "Overseer toggle"})
      vim.keymap.set("n", "<leader>or", function() ovs.run_task() end, {desc = "Overseer run"})

      local overseer_rerun = function()
        local tasks = ovs.list_tasks({recent_first = true})
        if vim.tbl_isempty(tasks) then
          vim.notify("No tasks found")
          return
        end
        local task = tasks[1]
        ovs.run_action(task, "restart")
      end
      vim.keymap.set("n", "<leader>oo", overseer_rerun, {desc = "Overseer rerun"})
    end
  },
}
