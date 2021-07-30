require'orgmode'.setup({
  org_agenda_files = {'~/Dropbox/Notes/**/*'},
  org_default_notes_file = '~/Dropbox/Notes/unsorted.org',
  mappings = {
    global = {
      org_agenda = '<leader>noa',
      org_capture = '<leader>noc'
    },
    capture = {
      org_capture_finalize = 'ZZ'
    }
  }
})
