return {
  {
    'TimUntersberger/neogit',
    dependencies = {
      "sindrets/diffview.nvim"
    },
    keys = {
      {"<leader>gg", function() require('neogit').open() end}
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup('ansauto_diffview', { clear = true }),
        pattern = {
          "DiffViewFiles"
        },
        callback = function (event)
          vim.keymap.set("n", "q", "<cmd>DiffviewClose<cr>", {
            buffer = event.buf,
            silent =  true,
            desc = "Close diffview"
          })
        end
      })
    end,
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
    "Rawnly/gist.nvim",
    cmd = { "GistCreate", "GistCreateFromFile", "GistsList" },
    opts = {}
  }
}
