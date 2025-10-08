-- highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- A little ninja
-- vim.lsp.set_log_level 'debug'

vim.api.nvim_create_user_command('LspLog', function()
  vim.cmd('e ' .. vim.lsp.get_log_path())
end, {})
