local packer = require("packer")
local use = packer.use

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'svermeulen/vimpeccable'
  use 'nvim-lua/plenary.nvim'

  use 'danro/rename.vim'

  use { 'easymotion/vim-easymotion', disable = true }
  use { 'ggandor/lightspeed.nvim', config = function() require'lightspeed'.setup{} end }

  use 'tpope/vim-surround'
  use { 'AndrewRadev/splitjoin.vim', config = function()
    vim.api.nvim_set_var('splitjoin_split_mapping', '')
    vim.api.nvim_set_var('splitjoin_join_mapping', '')
    local opts = {silent=true, noremap=true}
    vim.api.nvim_set_keymap('n', 'g[', [[:SplitjoinSplit<CR>]], opts)
    vim.api.nvim_set_keymap('n', 'g]', [[:SplitjoinJoin<CR>]], opts)
  end
  }

  use {
    'haya14busa/incsearch.vim',
    disable=true,
    config = function()
      vim.api.nvim_set_var('incsearch#auto_nohlsearch', 1)
      vim.api.nvim_set_keymap('', '/', [[<Plug>(incsearch-forward)]], {silent=true})
      vim.api.nvim_set_keymap('', '?', [[<Plug>(incsearch-backward)]], {silent=true})
      vim.api.nvim_set_keymap('', 'g/', [[<Plug>(incsearch-stay)]], {silent=true})
      local keys = {'n', 'N', '*', '#', 'g*', 'g#'}
      for _, key in ipairs(keys) do
        local rhs = string.format('<Plug>(incsearch-%s)', key)
        vim.api.nvim_set_keymap('', key, rhs, {silent=true})
      end
    end
  }

  use {'jalvesaq/nvim-r', ft = {"r", "rmd", "rnw"}}

  -- Python
  use {'hkupty/iron.nvim'}
  use {'GCBallesteros/jupytext.vim'}

  -- Julia
  use { 'JuliaEditorSupport/julia-vim', ft = {'julia'}, disable=true}

  use { 'bfredl/nvim-luadev' }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }

  use { 'dkarter/bullets.vim' , config = function()
    vim.g.bullets_set_mappings = 0
    vim.api.nvim_set_keymap('i', '<M-CR>', '<C-O>:InsertNewBullet<CR>', {silent=true, noremap=true})
    vim.api.nvim_set_keymap('n', '<C-C><C-C>', ':ToggleCheckbox<CR>', {silent=true, noremap=true})
  end}

  use { 'nvim-telescope/telescope-project.nvim' }

  -- Languageserver
  use { 'neovim/nvim-lspconfig' }
  use { 'kabouzeid/nvim-lspinstall' }

  use { "hrsh7th/nvim-compe" }

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    requires = {{ 'nvim-treesitter/nvim-treesitter' }}
  }
  -- Fallbacks for argument selection and exchange
  use { 'wellle/targets.vim' }
  use { 'tommcdo/vim-exchange' }

  use { 'TimUntersberger/neogit' }
  use { 'lewis6991/gitsigns.nvim', config = function() require('gitsigns').setup() end }

  use {
    'steelsojka/pears.nvim',
    config = function()
      require('pears').setup(function(conf)
        conf.on_enter(function(pears_handle)
          if vim.fn.pumvisible() == 1 and vim.fn.complete_info().selected ~= 1 then
            return vim.fn["compe#confirm"]("<CR>")
          else
            pears_handle()
          end
        end)
      end)
    end
  }

  use 'editorconfig/editorconfig-vim'
  use { 'b3nj5m1n/kommentary', config = function()
    local kc = require('kommentary.config')
    kc.configure_language('default', {
      prefer_single_line_comments = true
    })
  end
  }

  use {
    'akinsho/nvim-toggleterm.lua',
    config = function() require('toggleterm').setup{
      open_mapping = [[<c-\>]],
      direction = "float",
      hide_numbers = true
    } end
  }

  use 'sainnhe/sonokai'

end)
