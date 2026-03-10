local function get_custom_r_indent()
  local lnum = vim.v.lnum
  local cline = vim.fn.getline(lnum)

  -- Handle closers at the start of the line (e.g., ")", "})", "]]")
  local closer_match = cline:match("^%s*([%)%]%}]+)")
  if closer_match then
    local first_char = closer_match:sub(1,1)
    local opener = (first_char == ")") and "(" or (first_char == "]" and "[" or "{")
    
    local match_lnum = vim.fn.searchpair(opener, "", first_char, "bWn")
    if match_lnum > 0 then
      return vim.fn.indent(match_lnum)
    end
  end

  local prev_lnum = vim.fn.prevnonblank(lnum - 1)
  if prev_lnum == 0 then return 0 end
  local prev_line = vim.fn.getline(prev_lnum)

  -- Save cursor position for searchpair
  local save_cursor = vim.fn.getpos(".")
  
  -- Use built-in GetRIndent as base
  local base_indent = vim.fn.GetRIndent()
  local sw = vim.fn.shiftwidth()
  local prev_indent = vim.fn.indent(prev_lnum)

  -- Fix 1: Cap multi-opener indentation (e.g., list(list())
  -- Tidyverse style prefers 1 shiftwidth even if multiple openers on prev line.
  if base_indent > prev_indent + sw then
    if prev_line:match("[%(%{%[].*[%(%{%[]") or prev_line:match("[%(%{%[]%s*$") then
      base_indent = prev_indent + sw
    end
  end

  -- Fix 2: Reset indentation after a completed statement that ended in a closer.
  -- Built-in GetRIndent often stays at the opener's level if it was part of a pipe chain.
  if base_indent > 0 and (prev_line:match("%)%s*$") or prev_line:match("%]%s*$")) then
    local last_char = prev_line:gsub("%s*$", ""):sub(-1)
    local opener = (last_char == ")") and "(" or "["
    
    -- Move cursor to end of prev_line for searchpair
    vim.fn.cursor(prev_lnum, #prev_line)
    local match_lnum = vim.fn.searchpair(opener, "", last_char, "bWn")
    if match_lnum > 0 then
      local match_indent = vim.fn.indent(match_lnum)
      -- If GetRIndent is returning the indent of the opener's line, check for pipe chain
      if base_indent == match_indent then
        local p_lnum = vim.fn.prevnonblank(match_lnum - 1)
        if p_lnum > 0 then
          local p_line = vim.fn.getline(p_lnum)
          if p_line:match("|>%s*$") or p_line:match("%%>%%s*$") then
            -- Statement was part of a chain. Find the start of the chain.
            local chain_lnum = match_lnum
            while chain_lnum > 1 do
              local p = vim.fn.prevnonblank(chain_lnum - 1)
              if p == 0 then break end
              local pl = vim.fn.getline(p)
              if not (pl:match("|>%s*$") or pl:match("%%>%%s*$")) then break end
              chain_lnum = p
            end
            base_indent = vim.fn.indent(chain_lnum)
          end
        end
      end
    end
  end

  -- Restore cursor
  vim.fn.setpos(".", save_cursor)
  return base_indent
end

_G.get_custom_r_indent = get_custom_r_indent

-- Configure built-in R indent
vim.g.r_indent_align_args = 0
-- Ensure pipe is included in op_pattern
vim.g.r_indent_op_pattern = [[\(&\||\|+\|-\|\*\|/\|=\|\~\|%\|->\||>\)\s*$]]

vim.api.nvim_create_autocmd("FileType", {
  pattern = "r",
  callback = function()
    vim.opt_local.indentexpr = "v:lua.get_custom_r_indent()"
    vim.opt_local.indentkeys = "0{,0},:,!^F,o,O,e,0),0]"
  end
})

if vim.bo.filetype == "r" then
  vim.opt_local.indentexpr = "v:lua.get_custom_r_indent()"
  vim.opt_local.indentkeys = "0{,0},:,!^F,o,O,e,0),0]"
end
