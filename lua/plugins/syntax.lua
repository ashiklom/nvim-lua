return {
  {
    -- It causes all kinds of problems. Just use LSP + Treesitter instead.
    "JuliaEditorSupport/julia-vim",
    enabled = false,
    -- init = function()
    --   vim.g.latex_to_unicode_tab = "off"
    --   vim.g.latex_to_unicode_suggestions = 0
    --   vim.g.latex_to_unicode_auto = 1
    -- end
  },

  { "vim-pandoc/vim-pandoc", enabled = false },
  { "vim-pandoc/vim-pandoc-syntax", enabled = false },

  { "jxnblk/vim-mdx-js" },
  { "mracos/mermaid.vim", ft = { "mermaid" } },
  { "eigenfoo/stan-vim" },

  {
    "hat0uma/csvview.nvim",
    ft = { "csv" },
    opts = {
      keymaps = {
        textobject_field_inner = { "if", mode = { "o", "x" } },
        textobject_field_outer = { "af", mode = { "o", "x" } },
        jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
        jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
        jump_next_row = { "<Enter>", mode = { "n", "v" } },
        jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
      },
    },
    keys = {
      {
        "<localleader>T",
        function()
          require("csvview").toggle()
        end,
        mode = { "n", "x" },
        desc = "Toggle CSVview",
      },
    },
    cmd = { "CsvViewEnable", "CsvViewDisable", "CSvViewToggle" },
  },
}
