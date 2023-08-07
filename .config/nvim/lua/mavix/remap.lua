local remap = vim.keymap

vim.g.mapleader = " "
remap.set("n", "<leader>pv", vim.cmd.Ex)

remap.set("v", "J", ":m '>+1<CR>gv=gv")
remap.set("v", "K", ":m '<-2<CR>gv=gv")

remap.set("i", "<C-l>", "<right>")
remap.set("i", "<C-h>", "<left>")

-- increment
remap.set("n", "<C-i>", "<C-a>")

-- select all
remap.set("n", "<C-a>", "gg<S-v>G", { desc = "select all" })

remap.set("n", "J", "mzJ`z")
remap.set("n", "<C-d>", "<C-d>zz")
remap.set("n", "<C-u>", "<C-u>zz")
remap.set("n", "n", "nzzzv")
remap.set("n", "N", "Nzzzv")

-- greatest remap ever (?)
remap.set("x", "<leader>p", '"_dP')

-- keep nvim and system clipboards separated
remap.set("n", "<leader>y", '"+y')
remap.set("v", "<leader>y", '"+y')
remap.set("n", "<leader>Y", '"+Y')

remap.set("n", "<leader>d", '"_d')
remap.set("v", "<leader>d", '"_d')
remap.set("n", "x", '"_x') -- do not copy to the register

remap.set("n", "Q", "<nop>")
remap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
remap.set("n", "<leader>f", function()
	vim.lsp.buf.format()
end)

remap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
remap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
remap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
remap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

remap.set(
	"n",
	"<leader>r",
	":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
	{ desc = "match word cursor is currently on" }
)

-- chmod +x
remap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "Give a file execute permissions" }, { silent = true })

-- split window management
remap.set("n", "ss", ":vsplit<Return>", { desc = "split window vertical" }, { silent = true })
remap.set("n", "sv", ":split<Return>", { desc = "split window horizontal" }, { silent = true })
remap.set("n", "sx", "<C-w>c", { desc = "close split" })
remap.set("n", "sm", ":MaximizerToggle<CR>", { desc = "maximize split " })
remap.set("n", "sw", "<C-w>w", { desc = "traverse splits" })
remap.set("n", "sj", "<C-w>j", { desc = "move to window below" })
remap.set("n", "sk", "<C-w>k", { desc = "move to window below" })
remap.set("n", "sh", "<C-w>h", { desc = "move to window below" })
remap.set("n", "sl", "<C-w>l", { desc = "move to window below" })
remap.set("n", "so", "<C-w>o", { desc = "close all other windows" })

-- resize window
remap.set("n", "s<left>", "<C-w>>")
remap.set("n", "s<right>", "<C-w><")
remap.set("n", "s<up>", "<C-w>+")
remap.set("n", "s<down>", "<C-w>-")

-- tabs management
remap.set("n", "te", ":tabedit<Return>", { desc = "open a new tab" }, { silent = true })
remap.set("n", "tx", ":tabclose<Return>", { desc = "close tab" }, { silent = true })

-- plugin keymaps

-- nvim-tree
remap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- Remove all console logs (javascript)
remap.set("n", "<leader>xc", ":g/console.lo/d<CR>", { desc = "Remove all console.log" })

-- comment
remap.set("n", "<C-k>c", function()
	require("Comment.api").toggle.linewise.current()
end, { desc = "Toggle comment" })

remap.set(
	"v",
	"<C-k>c",
	"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
	{ desc = "Toggle comment" }
)

-- lspsaga
remap.set("n", "<C-ñ>", "<cmd>Lspsaga term_toggle<CR>")
