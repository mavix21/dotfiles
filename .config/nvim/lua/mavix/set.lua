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
--set.wildoptions = "pum"
--set.pumblend = 5
--set.background = "dark"

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

vim.opt.path:append({ "**" }) -- Finding files - Search down into subfolders
vim.opt.wildignore:append({ "*/node_modules/*" })

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set nopaste",
})

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })
