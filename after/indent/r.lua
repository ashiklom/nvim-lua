local function get_custom_r_indent()
  local lnum = vim.v.lnum
  local cline = vim.fn.getline(lnum)

  local closer = cline:match("^%s*([%)%]])")
  if closer then
    local opener = closer == ")" and "(" or "["
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
  local clean_line = line:gsub("%s*#.*$", ""):gsub("%s*$", "")
  local last_char = clean_line:sub(-1)

  if last_char == "(" or last_char == "[" then
    return vim.fn.indent(prev_lnum) + vim.fn.shiftwidth()
  end

  return vim.fn.indent(prev_lnum)
end

_G.get_custom_r_indent = get_custom_r_indent

vim.opt_local.indentexpr = "v:lua.get_custom_r_indent()"
vim.opt_local.indentkeys:append("0),0]")
