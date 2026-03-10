#!/usr/bin/env Rscript

# This script serves as a gold-standard test case for Neovim's R indentation (after/indent/r.lua).
# It enforces "Tidyverse-style" indentation rules:
#   - 2-space indentation (standard shiftwidth).
#   - NO argument alignment (arguments are indented by exactly 1 shiftwidth relative to the function call).
#   - Proper pipe chain handling (subsequent lines in a chain are indented relative to the start).
#   - Nested openers (like list(list())) only increment the indent level once per line.

# VERIFICATION GOAL:
# Running Neovim's indent command (gg=G) on this file should produce NO diff.

# HOW TO TEST:
# 1. Copy this file to a temporary location:
#    cp after/indent/indent-test.R /tmp/indent-test.R
# 2. Run Neovim in headless mode and apply indentation:
#    nvim --headless -c "set filetype=r" -c "normal gg=G" -c "wq" /tmp/indent-test.R
# 3. Compare the result with the original:
#    diff -u after/indent/indent-test.R /tmp/indent-test.R

if (something) {
  do_stuff(
    thing_1,
    thing_2
  )
}

something |>
  do_something_else |>
  do_another_thing(
    g = mutate(
      case_when(
        a == 3 ~ something,
        a == 4 ~ something_else
      )
    )
  )

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
  )
))

tibble::tribble(
  ~this, ~that, ~the_other,
  "something", "something_else", 3.56
)
