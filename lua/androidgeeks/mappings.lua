-- Map Leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local map = vim.keymap.set

map('n', '<leader>e', '<cmd>Ex<CR>', { desc = 'File Explorer', noremap = true, silent = true })

map('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save File', noremap = true, silent = true })
-- Quit / Exit Neovim
map('n', '<leader>q', '<cmd>q<CR>', { desc = 'Exit', noremap = true, silent = true })
-- Neo Tree
map('n', '<leader>t', '<cmd>Neotree toggle<CR>', { desc = 'File Explorer', noremap = true, silent = true })
-- Bufferline / Tabs
map('n', '<Tab>', '<cmd>bnext<CR>')
map('n', '<S-Tab>', '<cmd>bprevious<CR>')
map('n', '<leader>x', '<cmd>bdelete!<CR>') -- close buffer
map('n', '<leader>n', '<cmd>enew<CR>')     -- new buffer

-- Run code
map('n', '<leader>r', function()
  require('androidgeeks.term').run_current_file()
end, { desc = 'Run code', noremap = true, silent = true })
