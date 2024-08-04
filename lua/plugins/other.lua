return {
  { 'nvim-lua/plenary.nvim' },

  { 'danro/rename.vim' },

  {
    'hkupty/iron.nvim',
    config = function() require('configs.iron') end
  },

  { 'bfredl/nvim-luadev', ft = {"lua"} },

  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      {'<leader> ', [[:FzfLua files<CR>]], desc = "Files"},
      {'<leader>/', [[:FzfLua live_grep<CR>]], desc="Search project"},
      {'<leader>:', [[:FzfLua command_history<CR>]], desc="Command history"},

      {'<leader>ff', [[:FzfLua<CR>]], desc ="FzfLua"},
      {'<leader>fb', [[:FzfLua buffers<CR>]], desc="Buffers"},
      {'<leader>fg', [[:FzfLua git_files<CR>]], desc="Git files"},
      {'<leader>fr', [[:FzfLua oldfiles<CR>]], desc="Recent files"},

      {'<leader>s"', [[:FzfLua registers<CR>]], desc="Registers"},
      {'<leader>sb', [[:FzfLua current_buffer_fuzzy_find<CR>]], desc="Search buffer"},
      {'<leader>sc', [[:FzfLua commands<CR>]], desc="Commands"},
      {'<leader>sd', [[:FzfLua diagnostics_document<CR>]], desc="Diagnostics (document)"},
      {'<leader>sD', [[:FzfLua diagnostics_document<CR>]], desc="Diagnostics (workspace)"},
      {'<leader>sh', [[:FzfLua helptags<CR>]], desc="Help tags"},
      {'<leader>sk', [[:FzfLua keymaps<CR>]], desc="Keymaps"},
      {'<leader>sR', [[:FzfLua resume<CR>]], desc="Resume"},
      {'<leader>ss', [[:FzfLua lsp_document_symbols<CR>]], desc="Symbols (document)"},
      {'<leader>sS', [[:FzfLua lsp_workspace_symbols<CR>]], desc="Symbols (workspace)"},
      {'<leader>sq', [[:FzfLua quickfix<CR>]], desc="Quickfix list"},
      {'<leader>sw', [[:FzfLua grep_cword<CR>]], desc="Current word"},
      {'<leader>sw', [[:FzfLua grep_cWORD<CR>]], desc="Current WORD"},

      {'<leader>z=', [[:FzfLua spell_suggest<CR>]], desc="Spelling"}
    },
    config = function()
      local config = require("fzf-lua.config")
      local has_trbl, _ = pcall(require, "trouble")
      if has_trbl then
        local actions = require("trouble.sources.fzf").actions
        config.defaults.actions.files["ctrl-t"] = actions.open
      end
    end
  },

  {
    'nvim-treesitter/nvim-treesitter',
    -- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation#packernvim
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
    config = function() require('configs.treesitter') end
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' }
  },

  {
    'TimUntersberger/neogit',
    keys = {
      {"<leader>gg", function() require('neogit').open() end}
    },
    opts = {
      disable_commit_confirmation = true,
      mappings = {
        popup = {
          ["F"] = "PullPopup",
          ["p"] = "PushPopup"
        }
      },
      kind = "split_above",
      popup = {kind = "split_above"}
    }
  },

  {
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(_)
        local gs = package.loaded.gitsigns
        vim.keymap.set("n", "]h", gs.next_hunk, {desc="Next hunk"})
        vim.keymap.set("n", "[h", gs.prev_hunk, {desc="Previous hunk"})
        vim.keymap.set({"n", "v"}, "<leader>hh", gs.preview_hunk, {desc="Preview hunk"})
        vim.keymap.set({"n", "v"}, "<leader>hs", gs.stage_hunk, {desc="Stage hunk"})
        vim.keymap.set({"n", "v"}, "<leader>hx", gs.reset_hunk, {desc="Reset hunk"})
        vim.keymap.set({"n", "v"}, "<leader>hz", gs.undo_stage_hunk, {desc="Undo stage hunk"})
        vim.keymap.set("n", "<leader>hb", gs.blame_line, {desc="Blame line"})
        vim.keymap.set("n", "<leader>hA", function() require('gitsigns').setqflist("all") end, {desc="Quickfix all hunks"})
      end
    }
  },

  {
    'samoshkin/vim-mergetool',
    keys = {
      {"<leader>xt", "[[<Plug>(MergetoolToggle)]]", silent = true}
    },
    config = function()
      vim.g['mergetool_layout'] = 'mr'
      vim.g['mergetool_prefer_revision'] = 'local'
    end
  },

  {
    'akinsho/nvim-toggleterm.lua',
    config = function() require('configs.nvim-toggleterm') end
  },

  { 'sainnhe/sonokai' },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      sections = {
        lualine_c = {{'filename', path = 1}}
      }
    },
    enabled = false
  },
  { 'echasnovski/mini.statusline' , opts = {}},

  {
    'L3MON4D3/LuaSnip',
    config = function()
      require("luasnip.loaders.from_lua").lazy_load()
      require("luasnip.loaders.from_snipmate").lazy_load()
    end,
    keys = {
      {
        "<tab>",
        function()
          -- return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
          local lsp = require('luasnip')
          if lsp.expand_or_jumpable() then
            return "<Plug>luasnip-expand-or-jump"
          else
            return "<tab>"
          end
        end,
        expr = true, silent = true, mode = "i",
      },
      { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
  },

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
  }

}
