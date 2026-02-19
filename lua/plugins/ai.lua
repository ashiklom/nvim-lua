return {
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      ---@module 'snacks'
      { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
    },
    keys = {
      {
        "<leader>ai",
        function()
          require("opencode").toggle()
        end,
        desc = "Opencode toggle chat",
      },
    },
    config = function()
      -- Required for `opts.events.reload`.
      vim.o.autoread = true

      vim.keymap.set({"n", "x"}, "<leader>ap", function()
        require("opencode").select()
      end, { desc = "Opencode execute action" })

      vim.keymap.set("x", "<leader>ai", function()
        require("opencode").ask("@this: ", { submit = true })
      end, { desc = "Opencode ask this" })

      vim.keymap.set("x", "<leader>ao", function()
        return require("opencode").operator("@this ")
      end, { expr = true, desc = "Opencode add range" })

      vim.keymap.set("x", "<leader>al", function()
        return require("opencode").operator("@this ") .. "_"
      end, { expr = true, desc = "Opencode add line" })

      vim.keymap.set("n", "<leader>ab", function()
        return require("opencode").prompt("@buffer")
      end, { expr = true, desc = "Opencode add buffer" })

      vim.keymap.set("n", "<leader>a<tab>", function()
        require("opencode").command("agent.cycle")
      end, { desc = "Opencode toggle agent" })

      vim.keymap.set("n", "<leader>a-", function()
        require("opencode").command("session.half.page.up")
      end, { desc = "Opencode scroll up" })

      vim.keymap.set("n", "<leader>a=", function()
        require("opencode").command("session.half.page.down")
      end, { desc = "Opencode scroll down" })

      vim.keymap.set("n", "<leader>a0", function()
        require("opencode").command("session.last")
      end, { desc = "Opencode scroll bottom" })

      -- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o…".
      -- vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
      -- vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
    end,
  },
}
