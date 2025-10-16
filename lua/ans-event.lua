local function augroup(name)
  return vim.api.nvim_create_augroup("ansauto_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("spelling"),
  pattern = {
    "gitcommit",
    "markdown",
    "org",
    "plaintex",
    "quarto",
    "tex",
    "text",
  },
  command = "setlocal spell wrap"
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup('close_with_q'),
  pattern = {
    "help",
    "lspinfo",
    "notify",
    "qf",
    "checkhealth",
    "grug-far"
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", {
      buffer = event.buf,
      silent = true,
      desc = "Quit buffer"
    })
  end
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup('bufdelete_with_q'),
  pattern = {
    "oil"
  },
  callback = function(event)
    vim.keymap.set("n", "q", function() MiniBufremove.delete() end, {
      buffer = event.buf,
      silent = true,
      desc = "Quit buffer"
    })
  end
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup('formatoptions'),
  callback = function()
    vim.opt_local.formatoptions:remove({"o"})
  end
})

-- Automatically detect virtual environment
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("ansauto_venv", { clear = true }),
  pattern = { "python" },
  callback = function()
    if vim.env.VIRTUAL_ENV then
      return
    end
    local venv = vim.fn.getcwd() .. "/.venv"
    if not vim.fn.isdirectory(venv) then
      return
    end
    vim.env.VIRTUAL_ENV = venv
    vim.env.PYTHONHOME = nil
    vim.env.PATH = venv .. "/bin:" .. vim.env.PATH
    vim.notify("Set venv to " .. venv)
    -- Restart LSP to register new changes
    vim.defer_fn(function() 
      vim.cmd("LspRestart")
    end, 1000)
  end
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("ansauto_pixi", { clear = true }),
  callback = function()
    -- Don't set if a virtual environment is active
    if vim.env.VIRTUAL_ENV then
      return
    end
    -- ...or if pixi is already active.
    if vim.env.PIXI_PROJECT_NAME then
      return
    end
    -- ...or if the pixi directory doesn't exist.
    local cwd = vim.fn.getcwd()
    local pixidir = cwd .. "/.pixi"
    if not vim.fn.isdirectory(pixidir) then
      return
    end
    local pixiproj = vim.fn.fnamemodify(cwd, ":t")
    vim.env.PATH = pixidir .. "/envs/default/bin:" .. vim.env.PATH
    vim.env.CONDA_SHLVL = 1
    vim.env.CONDA_PREFIX = pixidir .. "/envs/default"
    -- vim.env.PIXI_PROJECT_MANIFEST = cwd .. "/pyproject.toml"
    -- vim.env.PIXI_PROJECT_VERSION = "0.1.0"
    vim.env.PIXI_IN_SHELL = 1
    vim.env.PIXI_PROJECT_ROOT = cwd
    vim.env.PIXI_PROJECT_NAME = pixiproj
    vim.env.PIXI_EXE = pixidir .. "/bin/pixi"
    vim.env.CONDA_DEFAULT_ENV = pixiproj
    -- vim.env.PIXI_ENVIRONMENT_NAME=default
    -- vim.env.PIXI_ENVIRONMENT_PLATFORMS=linux-64
    vim.notify("Activated pixi env in " .. pixidir)
    -- Restart LSP to register new changes
    vim.defer_fn(function() 
      vim.cmd("LspRestart")
    end, 1000)
  end
})

-- utils.augroup("Pandoc", {'BufNewFile', 'BufFilePre', 'BufRead'}, {
--   pattern = {"*.md"},
--   command = "set filetype=markdown.pandoc"
-- })
-- utils.augroup("Pandoc", "FileType", {
--   pattern = "telekasten", command = "set syntax=markdown.pandoc"
-- })

-- Automatically change window directory on file enter
-- utils.nvim_create_augroup("Chdir", {
--   {"BufEnter", "*", [[if g:fix_wd == 0 | execute 'lcd '.v:lua.git_cwd() | endif]]}
-- })

