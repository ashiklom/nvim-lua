#!/usr/bin/env Rscript

# Test file for R indentation in neovim (after/indent/r.lua).
# Expected: Running neovim's indent command (gg=G) on this file should produce no diff.
# To test: cp this file to /tmp, then run:
#   nvim --headless -c "set indentexpr=luaeval('get_custom_r_indent()')" -c "normal gg=G" -c "wq" /tmp/indent-test.R
# Then compare: diff indent-test.R /tmp/indent-test.R

settings <- PEcAn.settings::as.Settings(list(
  outdir = "...",
  rundir = "...",
  modeloutdir = "...",
  pfts = list(list(
    name = "grassland",
    constants = list(num = 1)
  )),
  model = list(
    type = "SIPNET",
    binary = binary,
    revision = "test",
    events = list(
      file = events_file,
      variables = c("pft")
    )
  ),
))

tibble::tribble(
  ~this, ~that, ~the_other,
  "something", "something_else", 3.56
)
