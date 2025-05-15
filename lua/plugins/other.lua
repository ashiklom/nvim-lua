return {
  { 'nvim-lua/plenary.nvim' },

  { 'danro/rename.vim' },

  { 'bfredl/nvim-luadev', ft = {"lua"} },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    opts = {
      auto_install = false
    }
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
      open_mapping = [[<c-\>]],
      direction = "float",
      hide_numbers = true
    }
  },

  { 'sainnhe/sonokai' },

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
  }

}
