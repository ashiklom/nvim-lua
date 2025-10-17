return {
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      {'<leader> ', function() require('fzf-lua').files() end, desc = "Files"},
      {'<leader>fr', function() require('fzf-lua').oldfiles() end, desc="Recent files"},

      {'<leader>bb', function() require('fzf-lua').buffers() end, desc ="Buffers"},

      {'<leader>/', function() require('fzf-lua').live_grep() end, desc="Search project"},
      {'<leader>sb', function() require('fzf-lua').lgrep_curbuf() end, desc="Search buffer"},
      {'<leader>sw', function() require('fzf-lua').grep_cword() end, desc="Current word"},
      {'<leader>sW', function() require('fzf-lua').grep_cWORD() end, desc="Current WORD"},

      {'<leader>ff', function() require('fzf-lua').builtin() end, desc ="FzfLua"},
      {'<leader>,', function() require('fzf-lua').resume() end, desc="Resume"},
      {'<leader>;', function() require('fzf-lua').commands() end, desc="Commands"},
      {'<leader>:', function() require('fzf-lua').command_history() end, desc="Command history"},

      {'<leader>gd', function() require('fzf-lua').lsp_definitions() end, mode = {"n", "x"}, desc = "LSP definitions"},
      {'<leader>gD', function() require('fzf-lua').lsp_declarations() end, mode = {"n", "x"}, desc = "LSP definitions"},

      {'<leader>s"', function() require('fzf-lua').registers() end, desc="Registers"},
      {'<leader>sc', function() require('fzf-lua').commands() end, desc="Commands"},
      {'<leader>sd', function() require('fzf-lua').diagnostics_document() end, desc="Diagnostics (document)"},
      {'<leader>sD', function() require('fzf-lua').diagnistics_workspace() end, desc="Diagnostics (workspace)"},
      {'<leader>sh', function() require('fzf-lua').helptags() end, desc="Help tags"},
      {'<leader>sk', function() require('fzf-lua').keymaps() end, desc="Keymaps"},
      {'<leader>sq', function() require('fzf-lua').quickfix() end, desc="Quickfix list"},

      {'z=', function() require('fzf-lua').spell_suggest() end, desc="Spelling"},

      {'<C-f>', function() require('fzf-lua').complete_path() end, mode="i", desc="Complete path"}
    },
    opts = {
      keymap = {
        builtin = {
          ["<M-0>"] = "toggle-preview",
          ["<M-=>"] = "toggle-fullscreen",
          ["<M-.>"] = "toggle-preview-cw",
          ["<M-,>"] = "toggle-preview-ccw",
          ["<M-/>"] = "toggle-help",
        }
      },
      winopts = {
        preview = {
          layout = "vertical"
        }
      }
    }
  },
}
