return {
  { 'nvim-lua/plenary.nvim' },

  { 'bfredl/nvim-luadev', ft = {"lua"} },

  {
    'folke/snacks.nvim',
    lazy = false,
    priority = 1000,
    init = function ()
      vim.api.nvim_create_autocmd("User", {
        pattern = "OilActionsPost",
        callback = function(event)
          if event.data.actions.type == "move" then
            Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
          end
        end,
      })
    end,
    opts = {
      quickfile = {enabled = true},
      bigfile = {enabled = true},
      statuscolumn = {enabled = false},
      rename = {enabled = true},
      indent = {
        enabled = true,
        animate = {enabled = false},
        scope = {
          only_current = true
        }
      }
    },
    keys = {
      {"<leader>z", function() Snacks.zen.zoom() end, desc = "Toggle zoom"},
      {"<leader>fR", function() Snacks.rename.rename_file() end, mode = {"n", "x"}, desc = "Rename file"},
      {"<leader>9", function() Snacks.scratch() end, desc = "Toggle scratch buffer"},
      {"<leader>(", function() Snacks.scratch.select() end, desc = "Search scratch buffer"}
    }
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    opts = {
      auto_install = false,
      indent = {enable = true},
      highlight = {enable = true},
      textobjects = {enable = true}
    },
    config = function (_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end
  },

  {
    'akinsho/nvim-toggleterm.lua',
    init = function ()
      vim.api.nvim_create_autocmd("User", {
        group = vim.api.nvim_create_augroup("ansauto_unception", { clear = true }),
        pattern = "UnceptionEditRequestReceived",
        callback = function ()
          -- Toggle terminal off
          local ttui = require('toggleterm.ui')
          local has_open, windows = ttui.find_open_windows()
          if has_open then
            ttui.close_and_save_terminal_view(windows)
          end
        end
      })
    end,
    opts = {
      direction = "horizontal"
    },
    keys = {
      {"<C-\\>", function() require("toggleterm").toggle() end, mode = {"n"}, desc = "Send line to term"},
      {"<leader>mt", function() require("toggleterm").send_lines_to_terminal("single_line", true) end, mode = {"n"}, desc = "Send line to term"},
      {"<leader>mt", function() require("toggleterm").send_lines_to_terminal("visual_selection", true) end, mode = {"x"}, desc = "Send selection to term"}
    }
  },

  -- Colorschemes
  { 'sainnhe/sonokai' },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function ()
      require('catppuccin').setup({
        integrations = {
          grug_far = true,
          leap = true,
          blink_cmp = true
        }
      })
      vim.cmd.colorscheme('catppuccin')
    end
  },

  { 'echasnovski/mini.statusline' , opts = {}},

  {
    'folke/trouble.nvim',
    opts = {},
    cmd = "Trouble",
    keys = {
      {"<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics"},
      {"<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer Diagnostics"},
      {"<leader>cs", "<cmd>Trouble symbols toggle focus=false<CR>", desc = "Symbols"},
      {"<leader>xc", "<cmd>Trouble qflist toggle<CR>", desc = "Quickfix list"},
      {"<leader>xl", "<cmd>Trouble loclist toggle<CR>", desc = "Location list"},
      {"<leader>gr", "<cmd>Trouble lsp_references toggle<CR>", desc = "LSP references"},
    }
  },

  -- Prevent nested neovim sessions (e.g., when calling nvim from terminal)
  {
    'samjwill/nvim-unception',
    lazy = false,
    init = function()
      -- Required by gist.nvim
      vim.g.unception_block_while_host_edits = true
    end
  },
  {
    'folke/persistence.nvim',
    event = "BufReadPre",
    opts = {},
    keys = {
      {"<leader>qs", function() require('persistence').load() end, desc = "Load session (working directory)"},
      {"<leader>qS", function() require('persistence').select() end, desc = "Load session (select)"},
      {"<leader>ql", function() require('persistence').load({last = true}) end, desc = "Load session (last)"},
      {"<leader>qd", function() require('persistence').stop() end, desc = "Stop persistence"},
      {"<leader>qq", function() vim.cmd.quitall() end, desc = "Quit all"}
    }
  }

}
