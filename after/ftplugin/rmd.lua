local rconfig = assert(loadfile(vim.fn.stdpath("config") .. "/after/ftplugin/r.lua"))
rconfig()

vim.api.nvim_win_set_option(0, "wrap", true)
