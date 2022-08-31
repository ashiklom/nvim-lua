local tk = require('telekasten')

local mt = require('ans-tele')

local notedir = vim.fn.expand('~/notes')
local config = vim.fn.stdpath('config')

tk.setup({
  home = notedir,
  take_over_my_home = true,
  auto_set_filetype = true,
  prefix_title_by_uuid = true,
  rename_update_links = true,
  dailies = notedir .. '/daily',
  weeklies = notedir .. '/weekly',
  templates = config .. '/note-templates',
  template_new_note = config .. '/note-templates/new_note.md',
  template_new_daily = config .. '/note-templates/daily.md',
  template_new_weekly = config .. '/note-templates/weekly.md',
  extension = ".md",
  new_note_filename = "uuid-title",
  uuid_type = "%Y-%m-%d-%H%M",
  uuid_sep = " ",
  tag_notation = "#tag",
})

vim.keymap.set('n', '<leader>nf', tk.find_notes)
vim.keymap.set('n', '<leader>nn', tk.new_note)
vim.keymap.set('n', '<leader>nN', tk.new_templated_note)
vim.keymap.set('n', '<leader>ng', tk.search_notes)
vim.keymap.set('n', '<leader>nz', tk.follow_link)
vim.keymap.set('n', '<leader>nr', tk.rename_note)
vim.keymap.set('n', '<leader>nc', tk.show_calendar)
vim.keymap.set('n', '<leader>na', tk.show_tags)

vim.keymap.set('n', '<leader>nd', tk.find_daily_notes)
vim.keymap.set('n', '<leader>nD', tk.goto_today)
vim.keymap.set('n', '<leader>nw', tk.find_weekly_notes)
vim.keymap.set('n', '<leader>nW', tk.goto_thisweek)

vim.keymap.set('n', '<leader>ns', mt.nsearch)

vim.keymap.set('i', '<C-z>', function() tk.insert_link({i=true}) end, {silent=true})
