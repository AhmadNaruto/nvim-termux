local o = vim.opt
local s = vim.cmd

s 'set expandtab'
s 'set tabstop=2'
s 'set softtabstop=2'
s 'set shiftwidth=2'
vim.g.have_nerd_font = false
o.number = true
o.relativenumber = false
o.showmode = false
o.breakindent = true
o.undofile = true
o.ignorecase = true
o.smartcase = true
o.signcolumn = 'yes'
o.updatetime = 250
o.timeoutlen = 300
o.splitright = true
o.splitbelow = true
o.list = true
o.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
o.inccommand = 'split'
o.cursorline = true
o.scrolloff = 10
o.wrap = false
