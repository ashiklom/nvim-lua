return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'svermeulen/vimpeccable'
	use 'nvim-lua/plenary.nvim'

	use 'tpope/vim-surround'
	use 'wellle/targets.vim'

	use {'jalvesaq/nvim-r', ft = {"r", "rmd", "rnw"}}

	use {
		'nvim-telescope/telescope.nvim',
		requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
	}

	use { 'nvim-telescope/telescope-project.nvim' }

	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

	use { 'lewis6991/gitsigns.nvim', config = function() require('gitsigns').setup() end }

	use { 'steelsojka/pears.nvim', config = function() require('pears').setup() end }

	use 'editorconfig/editorconfig-vim' 
	use 'b3nj5m1n/kommentary' 

    use {
        'akinsho/nvim-toggleterm.lua',
        config = function() require('toggleterm').setup{
            open_mapping = [[<c-\>]],
            direction = "float",
            hide_numbers = true
        } end 
    } 

	-- use 'joshdick/onedark.vim'
	use 'sainnhe/sonokai'

end)
