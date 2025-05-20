return {
  { 'JuliaEditorSupport/julia-vim'},

  { 'vim-pandoc/vim-pandoc', enabled = false },
  { 'vim-pandoc/vim-pandoc-syntax', enabled = false },

  { 'jxnblk/vim-mdx-js' },
  { 'mracos/mermaid.vim', ft = {"mermaid"} },
  { 'eigenfoo/stan-vim' },

  {
    'hat0uma/csvview.nvim',
    ft = {'csv'},
    opts = {
      keymaps = {
        textobject_field_inner = {"if", mode = {"o", "x"}},
        textobject_field_outer = {"af", mode = {"o", "x"}},
        jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
        jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
        jump_next_row = { "<Enter>", mode = { "n", "v" } },
        jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
      }
    },
    keys = {
      {"<localleader>t", function() require('csvview').toggle() end, mode = {"n", "x"}, desc = "Toggle CSVview"}
    },
    cmd = { "CsvViewEnable", "CsvViewDisable", "CSvViewToggle" }
  }
}
