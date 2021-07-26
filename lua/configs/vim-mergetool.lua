local vimp = require('vimp')

vim.g['mergetool_layout'] = 'mr'
vim.g['mergetool_prefer_revision'] = 'local'

vimp.rbind('n', '<leader>xt', [[<Plug>(MergetoolToggle)]])
