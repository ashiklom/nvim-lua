return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
      {'yamatsum/nvim-nonicons'},
      {'kyazdani42/nvim-web-devicons'}
    }
  },
  {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
  {'nvim-telescope/telescope-project.nvim'},
  {'nvim-telescope/telescope-file-browser.nvim'},
  {
    'renerocksai/telekasten.nvim',
    dependencies = {{ 'renerocksai/calendar-vim' }},
    config = function() require('configs.telekasten') end
  }
}
