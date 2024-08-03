return {
  {
    'GCBallesteros/jupytext.vim',
    config = function()
      vim.g.jupytext_fmt = 'py'
      vim.g.jupytext_style = 'hydrogen'
    end
  },
  { 'Vimjas/vim-python-pep8-indent', ft = {"python"} },
}
