local utils = {}

function utils.nvim_create_augroup(group_name, definition)
  vim.api.nvim_command('augroup '..group_name)
  vim.api.nvim_command('autocmd!')
  for _, def in ipairs(definition) do
    local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
    vim.api.nvim_command(command)
  end
  vim.api.nvim_command('augroup END')
end

return utils
