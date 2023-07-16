local set = vim.opt

set.nu = true -- line numbers
set.relativenumber = true -- relative line numbers

set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.expandtab = false

set.smartindent = true

set.wrap = false

set.hlsearch = false
set.incsearch = true

set.termguicolors = true

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
