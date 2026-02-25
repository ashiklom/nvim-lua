local function get_custom_r_indent()
  local lnum = vim.v.lnum
  local cline = vim.fn.getline(lnum)

  -- 1. If the CURRENT line starts with a closing paren/bracket,
  -- align it with the matching opener.
  local closer = cline:match("^%s*([%)%]])")
  if closer then
    local opener = closer == ")" and "(" or "["
    -- searchpair(start, middle, end, flags)
    -- 'bWn' means: backward, no wrap, no moving cursor
    local match_lnum = vim.fn.searchpair(opener, "", closer, "bWn")
    if match_lnum > 0 then
      return vim.fn.indent(match_lnum)
    end
  end

  local prev_lnum = vim.fn.prevnonblank(lnum - 1)
  if prev_lnum == 0 then
    return 0
  end

  local line = vim.fn.getline(prev_lnum)
  -- Remove trailing whitespace and comments to check the "true" end of the line
  local clean_line = line:gsub("%s*#.*$", ""):gsub("%s*$", "")

  -- 2. If the PREVIOUS line ends with an opener, indent by shiftwidth.
  local last_char = clean_line:sub(-1)
  if last_char == "(" or last_char == "[" then
    return vim.fn.indent(prev_lnum) + vim.fn.shiftwidth()
  end

  -- 3. Otherwise, fall back to the built-in R indentation logic.
  if vim.fn.exists("*GetRIndent") == 1 then
    return vim.fn.GetRIndent()
  end

  -- Ultimate fallback
  return vim.fn.indent(prev_lnum)
end

-- Global function accessible by indentexpr
_G.get_custom_r_indent = get_custom_r_indent

-- Set the indentexpr to our Lua function
vim.opt_local.indentexpr = "v:lua.get_custom_r_indent()"

-- Ensure closing punctuation triggers re-indentation
vim.opt_local.indentkeys:append("0),0]")
