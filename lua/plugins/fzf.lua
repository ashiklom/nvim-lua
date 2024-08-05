return {
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      {'<leader> ', [[:FzfLua files<CR>]], desc = "Files"},
      {'<leader>/', [[:FzfLua live_grep<CR>]], desc="Search project"},
      {'<leader>:', [[:FzfLua command_history<CR>]], desc="Command history"},

      {'<leader>ff', [[:FzfLua<CR>]], desc ="FzfLua"},
      {'<leader>fb', [[:FzfLua buffers<CR>]], desc="Buffers"},
      {'<leader>fg', [[:FzfLua git_files<CR>]], desc="Git files"},
      {'<leader>fr', [[:FzfLua oldfiles<CR>]], desc="Recent files"},

      {'<leader>s"', [[:FzfLua registers<CR>]], desc="Registers"},
      {'<leader>sb', [[:FzfLua current_buffer_fuzzy_find<CR>]], desc="Search buffer"},
      {'<leader>sc', [[:FzfLua commands<CR>]], desc="Commands"},
      {'<leader>sd', [[:FzfLua diagnostics_document<CR>]], desc="Diagnostics (document)"},
      {'<leader>sD', [[:FzfLua diagnostics_document<CR>]], desc="Diagnostics (workspace)"},
      {'<leader>sh', [[:FzfLua helptags<CR>]], desc="Help tags"},
      {'<leader>sk', [[:FzfLua keymaps<CR>]], desc="Keymaps"},
      {'<leader>sR', [[:FzfLua resume<CR>]], desc="Resume"},
      {'<leader>ss', [[:FzfLua lsp_document_symbols<CR>]], desc="Symbols (document)"},
      {'<leader>sS', [[:FzfLua lsp_workspace_symbols<CR>]], desc="Symbols (workspace)"},
      {'<leader>sq', [[:FzfLua quickfix<CR>]], desc="Quickfix list"},
      {'<leader>sw', [[:FzfLua grep_cword<CR>]], desc="Current word"},
      {'<leader>sw', [[:FzfLua grep_cWORD<CR>]], desc="Current WORD"},

      {'z=', [[:FzfLua spell_suggest<CR>]], desc="Spelling"}
    },
    config = function()
      local config = require("fzf-lua.config")
      local has_trbl, _ = pcall(require, "trouble")
      if has_trbl then
        local actions = require("trouble.sources.fzf").actions
        config.defaults.actions.files["ctrl-t"] = actions.open
      end
    end
  },
}
