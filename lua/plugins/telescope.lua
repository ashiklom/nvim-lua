return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
      {'yamatsum/nvim-nonicons'},
      {'nvim-tree/nvim-web-devicons'}
    }
  },
  {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
  {'nvim-telescope/telescope-project.nvim'},
  {'nvim-telescope/telescope-file-browser.nvim'},
  {
    'ashiklom/telescope-bibtex.nvim',
    config = function()
      local tele = require("telescope")
      tele.load_extension("bibtex")
      tele.setup{
        extensions = {
          bibtex = {
            global_files = {"/home/ashiklom/zotero-library.bib"}
          }
        }
      }
    end
  },
  {
    'renerocksai/telekasten.nvim',
    dependencies = {{ 'renerocksai/calendar-vim' }},
    config = function() require('configs.telekasten') end
  }
}
