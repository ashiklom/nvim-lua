return {
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      {'<leader> ', function() require('fzf-lua').files() end, desc = "Files"},
      {'<leader>/', function() require('fzf-lua').live_grep() end, desc="Search project"},
      {'<leader>:', function() require('fzf-lua').command_history() end, desc="Command history"},

      {'<leader>ff', function() require('fzf-lua').builtin() end, desc ="FzfLua"},
      {'<leader>bb', function() require('fzf-lua').buffers() end, desc ="Buffers"},
      {'<leader>fg', function() require('fzf-lua').git_files() end, desc="Git files"},
      {'<leader>fr', function() require('fzf-lua').oldfiles() end, desc="Recent files"},

      {'<leader>s"', function() require('fzf-lua').registers() end, desc="Registers"},
      {'<leader>sb', function() require('fzf-lua').current_buffer_fuzzy_find() end, desc="Search buffer"},
      {'<leader>sc', function() require('fzf-lua').commands() end, desc="Commands"},
      {'<leader>sd', function() require('fzf-lua').diagnostics_document() end, desc="Diagnostics (document)"},
      {'<leader>sD', function() require('fzf-lua').diagnistics_workspace() end, desc="Diagnostics (workspace)"},
      {'<leader>sh', function() require('fzf-lua').helptags() end, desc="Help tags"},
      {'<leader>sk', function() require('fzf-lua').keymaps() end, desc="Keymaps"},
      {'<leader>sR', function() require('fzf-lua').resume() end, desc="Resume"},
      {'<leader>ss', function() require('fzf-lua').lsp_document_symbols() end, desc="Symbols (document)"},
      {'<leader>sS', function() require('fzf-lua').lsp_workspace_symbols() end, desc="Symbols (workspace)"},
      {'<leader>sq', function() require('fzf-lua').quickfix() end, desc="Quickfix list"},
      {'<leader>sw', function() require('fzf-lua').grep_cword() end, desc="Current word"},
      {'<leader>sw', function() require('fzf-lua').grep_cWORD() end, desc="Current WORD"},

      {'z=', function() require('fzf-lua').spell_suggest() end, desc="Spelling"}
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
