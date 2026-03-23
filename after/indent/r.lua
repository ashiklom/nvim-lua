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
  local prev_last_char = prev_trimmed:sub(-1)
  if base_indent == 0 and (prev_last_char == ")" or prev_last_char == "]") then
    local opener = (prev_last_char == ")") and "(" or "["

    vim.fn.cursor(prev_lnum, #prev_trimmed)
    local match_lnum = vim.fn.searchpair(opener, "", prev_last_char, "bWn")
    if match_lnum > 0 then
      local match_indent = vim.fn.indent(match_lnum)
      if match_indent > base_indent then
        base_indent = match_indent
      end
    end
  end

  -- Fix 3: Keep pipe continuation indented after a standalone `)`/`] |> ` line.
  -- This preserves the chain indent when a step ends with a closing delimiter.
  -- Example:
  -- x |>
  --   fn(
  --     a
  --   ) |>
  --   next_step()
  if base_indent <= prev_indent then
    if prev_line:match("^%s*%)%s*|>%s*$") or prev_line:match("^%s*%)%s*%%>%%%s*$")
      or prev_line:match("^%s*%]%s*|>%s*$") or prev_line:match("^%s*%]%s*%%>%%%s*$") then
      base_indent = prev_indent + sw
    end
  end

  -- Fix 4: Reset to the pipe-chain indent after a completed `)` or `]` step.
  -- Built-in `GetRIndent()` can otherwise stick to the matched opener's column.
  -- Example:
  -- x |>
  --   fn(
  --     a
  --   )
  -- next_call()
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
