local function get_matching_opener(closer)
  if closer == ")" then return "(" end
  if closer == "]" then return "[" end
  if closer == "}" then return "{" end
end

local function is_pipe_line(line)
  return line:match("|>%s*$") or line:match("%%>%%s*$")
end

local function find_matching_lnum(lnum, closer, col)
  local opener = get_matching_opener(closer)
  if not opener then return 0 end

  vim.fn.cursor(lnum, col)
  return vim.fn.searchpair(opener, "", closer, "bWn")
end

-- Given a line number that is part of a pipe chain (possibly a `) |>` line),
-- walk backward to find the line number where the pipe chain starts.
local function find_pipe_chain_start(lnum)
  local chain_lnum = lnum
  while true do
    local line = vim.fn.getline(chain_lnum)
    -- If this line ends with ) |> or ] |>, jump through to its matching opener.
    local trimmed = line:gsub("%s*|>%s*$", ""):gsub("%s*%%>%%%s*$", "")
    local last_char = trimmed:sub(-1)
    if last_char == ")" or last_char == "]" then
      local m = find_matching_lnum(chain_lnum, last_char, #trimmed)
      if m > 0 then
        chain_lnum = m
        -- Continue walking from the opener line.
      else
        break
      end
    else
      -- Plain pipe line (ends with |> but not with )). Walk to prev pipe line.
      local p = vim.fn.prevnonblank(chain_lnum - 1)
      if p == 0 then break end
      local pl = vim.fn.getline(p)
      if not is_pipe_line(pl) then break end
      chain_lnum = p
    end
  end
  return chain_lnum
end

local function get_completed_item_indent(base_indent, prev_lnum, prev_trimmed)
  local prev_last_char = prev_trimmed:sub(-1)
  if base_indent ~= 0 or (prev_last_char ~= ")" and prev_last_char ~= "]") then
    return nil
  end

  local match_lnum = find_matching_lnum(prev_lnum, prev_last_char, #prev_trimmed)
  if match_lnum == 0 then return nil end

  local match_indent = vim.fn.indent(match_lnum)
  if match_indent <= base_indent then return nil end

  return match_indent
end

local function get_pipe_continuation_indent(base_indent, prev_indent, prev_lnum, prev_line, sw)
  if not (
    prev_line:match("^%s*%)%s*|>%s*$")
    or prev_line:match("^%s*%)%s*%%>%%%s*$")
    or prev_line:match("^%s*%]%s*|>%s*$")
    or prev_line:match("^%s*%]%s*%%>%%%s*$")
  ) then
    return nil
  end

  -- Find the matching opener for the closing delimiter.
  local prev_trimmed = prev_line:gsub("%s*|>%s*$", ""):gsub("%s*%%>%%%s*$", "")
  local last_char = prev_trimmed:sub(-1)
  local match_lnum = find_matching_lnum(prev_lnum, last_char, #prev_trimmed)
  if match_lnum == 0 then return nil end

  -- Walk backward along the pipe chain from the opener to find the chain's first step.
  -- The correct indent for the next pipe step is: chain_start_indent + sw.
  local chain_start = find_pipe_chain_start(match_lnum)
  return vim.fn.indent(chain_start) + sw
end

local function get_pipe_chain_reset_indent(base_indent, prev_lnum, prev_line)
  if base_indent <= 0 then return nil end
  if not (prev_line:match("%)%s*$") or prev_line:match("%]%s*$")) then
    return nil
  end

  local prev_trimmed = prev_line:gsub("%s*$", "")
  local last_char = prev_trimmed:sub(-1)
  local match_lnum = find_matching_lnum(prev_lnum, last_char, #prev_trimmed)
  if match_lnum == 0 then return nil end

  local match_indent = vim.fn.indent(match_lnum)
  if base_indent ~= match_indent then return nil end

  local p_lnum = vim.fn.prevnonblank(match_lnum - 1)
  if p_lnum == 0 then return nil end

  local p_line = vim.fn.getline(p_lnum)
  if not is_pipe_line(p_line) then return nil end

  local chain_start = find_pipe_chain_start(match_lnum)
  return vim.fn.indent(chain_start)
end

local function get_custom_r_indent()
  local lnum = vim.v.lnum
  local cline = vim.fn.getline(lnum)

  -- Handle closers at the start of the line (e.g., ")", "})", "]]")
  local closer_match = cline:match("^%s*([%)%]%}]+)")
  if closer_match then
    local first_char = closer_match:sub(1,1)
    -- Use the actual column of the closer, not 1, so searchpair finds the right opener.
    local leading = #cline - #cline:gsub("^%s*", "")
    local match_lnum = find_matching_lnum(lnum, first_char, leading + 1)
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
  local prev_trimmed = prev_line:gsub("%s*,?%s*$", "")

  -- Fix 1: Cap lines after nested openers to one shiftwidth.
  -- Tidyverse style prefers a single indent step after `list(list(`-style lines.
  -- Example:
  -- x <- list(list(
  --   a = 1
  -- ))
  if base_indent > prev_indent + sw then
    if prev_line:match("[%(%{%[].*[%(%{%[]") or prev_line:match("[%(%{%[]%s*$") then
      base_indent = prev_indent + sw
    end
  end

  -- Fix 2: Keep the next sibling aligned after an item ending in `)` or `]`.
  -- This avoids jumping back to the outer opener inside list-like constructs.
  -- Example:
  -- list(
  --   fn(a),
  --   next_item
  -- )
  base_indent = get_completed_item_indent(base_indent, prev_lnum, prev_trimmed) or base_indent

  -- Fix 3: Keep pipe continuation indented after a standalone `)`/`] |> ` line.
  -- This preserves the chain indent when a step ends with a closing delimiter.
  -- Example:
  -- x |>
  --   fn(
  --     a
  --   ) |>
  --   next_step()
  base_indent = get_pipe_continuation_indent(base_indent, prev_indent, prev_lnum, prev_line, sw) or base_indent

  -- Fix 4: Reset to the pipe-chain indent after a completed `)` or `]` step.
  -- Built-in `GetRIndent()` can otherwise stick to the matched opener's column.
  -- Example:
  -- x |>
  --   fn(
  --     a
  --   )
  -- next_call()
  base_indent = get_pipe_chain_reset_indent(base_indent, prev_lnum, prev_line) or base_indent

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
