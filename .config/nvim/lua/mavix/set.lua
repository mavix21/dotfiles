local set = vim.opt

set.nu = true -- line numbers
set.relativenumber = true -- relative line numbers

-- tabs
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.expandtab = false

set.smartindent = true

set.wrap = false

set.hlsearch = false
set.incsearch = true

-- highlights
set.termguicolors = true
set.cursorline = true
set.winblend = 0
set.wildoptions = "pum"
set.pumblend = 5
set.background = "dark"

-- highlight yanked text for 200ms using the "visual" highlight group
vim.cmd([[
  augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=100})
  augroup END
]])

set.scrolloff = 8
set.signcolumn = "yes"
set.isfname:append("@-@")

set.splitbelow = true
set.splitright = true
set.fileencoding = "utf-8"

set.updatetime = 50

set.colorcolumn = "80"

-- backspace
set.backspace = "indent,eol,start"

set.iskeyword:append("-")

set.hidden = true
