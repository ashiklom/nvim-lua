require('nvim-treesitter').install({
  "svelte",
  "typescript",
  "javascript",
  "html",
  "css"
})

vim.treesitter.start()
