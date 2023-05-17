return {
  -- Languageserver
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig"
    },
    config = function() require('configs.lsp') end
  },
  {
    'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim',
    config = function() require('configs.toggle_lsp_diagnostics') end
  }
}
