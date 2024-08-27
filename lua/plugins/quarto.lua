return {
  {
    'quarto-dev/quarto-nvim',
    ft = {'quarto'},
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter"
    },
    opts = {}
  },
  {
    'jmbuhr/otter.nvim',
    opts = {buffers = {write_to_disk = true}}  -- Needed for some linters...
  }
}
