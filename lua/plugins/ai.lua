return {
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      {
        "folke/snacks.nvim",
        optional = true,
        opts = { input = {}, picker = {} },
      },
    },
    keys = {
      {
        "<leader>ai",
        function()
          require("opencode").ask("@buffer: ", { submit = true })
        end,
        desc = "Opencode ask this",
        mode = "n",
      },
      {
        "<leader>ai",
        function()
          require("opencode").ask("@this: ", { submit = true })
        end,
        desc = "Opencode ask this",
        mode = "x",
      },
      {
        "<leader>ap",
        function()
          require("opencode").select()
        end,
        desc = "Opencode execute action",
        mode = { "n", "x" },
      },
      {
        "<leader>ao",
        function()
          return require("opencode").operator("@this ")
        end,
        desc = "Opencode add range",
        mode = "x",
      },
      {
        "<leader>al",
        function()
          return require("opencode").operator("@this ") .. "_"
        end,
        desc = "Opencode add line",
        mode = "x",
      },
      {
        "<leader>ab",
        function()
          return require("opencode").prompt("@buffer")
        end,
        desc = "Opencode add buffer",
        mode = "n",
      },
      {
        "<leader>a<tab>",
        function()
          require("opencode").command("agent.cycle")
        end,
        desc = "Opencode toggle agent",
        mode = "n",
      },
      {
        "<leader>a-",
        function()
          require("opencode").command("session.half.page.up")
        end,
        desc = "Opencode scroll up",
        mode = "n",
      },
      {
        "<leader>a=",
        function()
          require("opencode").command("session.half.page.down")
        end,
        desc = "Opencode scroll down",
        mode = "n",
      },
      {
        "<leader>a0",
        function()
          require("opencode").command("session.last")
        end,
        desc = "Opencode scroll bottom",
        mode = "n",
      },
    },
    config = function()
      vim.o.autoread = true
    end,
  },
}
