return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {"rcarriga/nvim-dap-ui", opts = {}},
      "nvim-neotest/nvim-nio",
      "mfussenegger/nvim-dap-python",
    },
    keys = {
      {"<leader>db", function() require('dap').toggle_breakpoint() end, mode = {"n"}, desc = "DAP toggle breakpoint"},
      {"<leader>d.", function() require('dap').run_to_cursor() end, mode = {"n"}, desc = "DAP run to cursor"},
      {"<leader>dc", function() require('dap').continue() end, mode = {"n"}, desc = "DAP continue"},
      {"<leader>di", function() require('dap').step_into() end, mode = {"n"}, desc = "DAP step into"},
      {"<leader>do", function() require('dap').step_out() end, mode = {"n"}, desc = "DAP step out"},
      {"<leader>dn", function() require('dap').step_over() end, mode = {"n"}, desc = "DAP step over"},
      {"<leader>d-", function() require('dap').step_back() end, mode = {"n"}, desc = "DAP step back"},
      {"<leader>dr", function() require('dap').repl.toggle() end, mode = {"n"}, desc = "DAP open repl"},
      {"<leader>dR", function() require('dap').run_last() end, mode = {"n"}, desc = "DAP run last"},
      {"<leader>d=", function() require('dapui').eval(nil, { enter = true }) end, mode = {"n"}, desc = "DAP eval under cursor"},
      {"<leader>dw", function() require('dapui').toggle() end, mode = {"n"}, desc = "DAP eval under cursor"},
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    config = function ()
      require('dap-python').setup("uv")
    end
  }
}
