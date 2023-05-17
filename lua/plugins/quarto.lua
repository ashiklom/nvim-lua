return {
  {
    'quarto-dev/quarto-nvim',
    ft = {'quarto'},
    dependencies = { "jmbuhr/otter.nvim" },
    config = function() require('quarto').setup{ }
    end
  }
}
