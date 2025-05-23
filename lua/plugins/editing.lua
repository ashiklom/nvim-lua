return {
  {
    'ggandor/leap.nvim',
    config = function() require('leap').set_default_keymaps() end
  },

  {
    'kylechui/nvim-surround',
    opts = {}
  },
  {
    'echasnovski/mini.splitjoin',
    config = function()
      local ms = require('mini.splitjoin')
      ms.setup{
        mappings = {
          toggle = 'g[',
          split = 'g{',
          join = 'g}'
        }
      }
      vim.keymap.set('i', '<C-]>', ms.toggle, {desc="Toggle splitjoin"})
    end
  },
  {
    'echasnovski/mini.pairs',
    opts = {}
  },
  {
    'echasnovski/mini.move',
    opts = {
      mappings = {
        left = "<S-left>",
        right = "<S-right>",
        up = "<S-up>",
        down = "<S-down>",
        line_left = "<S-left>",
        line_right = "<S-right>",
        line_up = "<S-up>",
        line_down = "<S-down>"
      }
    },
  },

  { 'editorconfig/editorconfig-vim' },

  {
    'dhruvasagar/vim-table-mode',
    ft = {'markdown'},
    -- NOTE: init to run before
    init = function()
      vim.g["table_mode_map_prefix"] = "<localleader>t"
    end,
    config = function ()
      vim.keymap.set('n', '<localleader>tr', [[:call tablemode#table#Realign('.')<CR>]], {desc="Table realign", silent=true})
    end
  },

  -- Fallbacks for argument selection and exchange
  {
    'echasnovski/mini.ai',
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        mappings = {
          -- Custom mappings to avoid conflicts with mini.splitjoin
          goto_left = "gs[",
          goto_right = "gs]"
        },
        custom_textobjects = {
          o = ai.gen_spec.treesitter({ -- code block
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
          d = { "%f[%d]%d+" }, -- digits
          e = { -- Word with case
            { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
            "^().*()$",
          },
          -- g = LazyVim.mini.ai_buffer, -- buffer
          u = ai.gen_spec.function_call(), -- u for "Usage"
          U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
        }
      }
    end,
  },
  {
    "gbprod/substitute.nvim",
    keys = {
      {"gx", function() require('substitute.exchange').visual() end, mode="x", noremap=true},
      {"gx", function() require('substitute.exchange').operator() end, noremap=true},
      {"gX", function() require('substitute.exchange').line() end, noremap=true}
    },
    opts = {}
  },
  {
    "stevearc/conform.nvim",
    init = function ()
      -- Set buffer formatting 
      vim.g.disable_autoformat = true
      vim.api.nvim_create_autocmd("BufRead", {
        group = vim.api.nvim_create_augroup("ansauto_autoformat", { clear = true }),
        pattern = "*",
        callback = function (event)
          vim.b[event.buf].disable_autoformat = vim.g.disable_autoformat
        end
      })
    end,
    keys = {
      {
        "<leader>fm",
        function() require('conform').format({async = true}) end,
        mode = {"n", "x"},
        desc = "Format buffer",
      },
      {"<leader>fM", function ()
        vim.b.disable_autoformat = not(vim.b.disable_autoformat)
        local text = (vim.b.disable_autoformat and "disabled" or "enabled")
        vim.notify("Buffer autoformatting is " .. text)
      end, desc = "Toggle format on save (buffer)"},
      {"<leader>FM", function ()
        vim.g.disable_autoformat = not(vim.g.disable_autoformat)
        local text = (vim.g.disable_autoformat and "disabled" or "enabled")
        vim.notify("Global autoformatting is " .. text)
      end, desc = "Toggle format on save (global)"}
    },
    opts = {
      formatters_by_ft = {
        lua = {"stylua"},
        python = {"isort", "black"},
        r = {"air"},
        hcl = {"hclfmt"},
        sh = {"shfmt"}
      },
      default_format_opts = {
        lsp_format = "fallback"
      },
      format_on_save = function (bufnr)
        if vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 500, lsp_format = "fallback" }
      end
    }
  },
  {
    "magicduck/grug-far.nvim",
    opts = {},
    keys = {
      {
        "<leader>rf",
        function() require('grug-far').open({ prefills = { paths = vim.fn.expand("%") } }) end,
        desc = "Find-replace current file"
      },
      {
        "<leader>rp",
        function() require('grug-far').open() end,
        desc = "Find-replace current project"
      },
      {
        "<leader>rf",
        function() require('grug-far').with_visual_selection({
          prefills = { search = vim.fn.expand("<cword>"), paths = vim.fn.expand("%") }
        }) end,
        mode = "x",
        desc = "Find-replace selection"
      },
      {
        "<leader>rp",
        function() require('grug-far').with_visual_selection({
          prefills = { search = vim.fn.expand("<cword>") }
        }) end,
        mode = "x",
        desc = "Find-replace selection"
      },
    }
  }
}
