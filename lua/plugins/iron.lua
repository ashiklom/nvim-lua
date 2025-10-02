return {
  {
    "hkupty/iron.nvim",
    config = function()
      -- Function to unindent a block of code
      local function unindent_block(lines)
        -- Find the indentation of the first line
        local first_indent = lines[1]:match("^%s*")
        local indent_length = #first_indent

        -- Function to remove indentation from a single line
        local function remove_indent(line)
          return line:sub(indent_length + 1)
        end

        -- Apply the remove_indent function to all lines
        return vim.tbl_map(remove_indent, lines)
      end

      local function python_config()
        if vim.fn.executable("ipython") then
          return {
            command = { "ipython", "--no-autoindent", "--no-confirm-exit" },
            format = require("iron.fts.common").bracketed_paste_python,
          }
        end
        return {
          command = { "python3" },
          format = function(lines, extras)
            local unindented = unindent_block(lines)
            -- Note: Simplify the formatting, so just use `bracketed_paste` (not bracketed_paste_python) here
            return require("iron.fts.common").bracketed_paste(unindented, extras)
          end,
        }
      end

      local iron = require("iron.core")
      local common = require("iron.fts.common")

      -- For haskell, wrap multiline statements in :{ ... :}
      local function haskell_fmt(lines)
        local cr = "\13"
        if #lines == 1 then
          return { lines[1] .. cr }
        end
        local result = {}
        table.insert(result, ":{")
        for _, line in ipairs(lines) do
          table.insert(result, line)
        end
        table.insert(result, ":}" .. cr)
        return result
      end

      iron.setup({
        config = {
          repl_open_cmd = "botright 15 split",
          buflisted = true,
          repl_definition = {
            python = python_config(),
            r = { command = { "R" } },
            julia = { command = { "julia" } },
            sh = { command = { "bash" } },
            -- ps1 = { command = { "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe" } },
            ps1 = { command = { "powershell" } },
            terraform = { command = { "terraform", "console" } },
            haskell = { command = { "ghci" }, format = haskell_fmt }
          },
        },
        keymaps = {
          toggle_repl = "<localleader>rf",
          restart_repl = "<localleader>rR",
          exit = "<localleader>rq",
          send_line = "<localleader>l",
          send_paragraph = "<localleader>pp",
          interrupt = "<localleader>x",
          clear = "<localleader>X",
          send_file = "<localleader>aa",
          visual_send = "<localleader>ss",
        },
      })
    end,
  },
}
