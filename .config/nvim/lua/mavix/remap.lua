local remap = vim.keymap

vim.g.mapleader = " "
remap.set("n", "<leader>pv", vim.cmd.Ex)

remap.set("v", "J", ":m '>+1<CR>gv=gv")
remap.set("v", "K", ":m '<-2<CR>gv=gv")

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

remap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- chmod +x
remap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true }, { desc = "Give file execute permissions" })

remap.set("n", "<leader>to", ":tabnew<CR>", { desc = "Open a new tab" }) -- open new tab
remap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
remap.set("n", "<leader>tn", ":tabn<CR>") -- go to next tab
remap.set("n", "<leader>tp", ":tabp<CR>") -- go to previous tab

-- plugin keymaps

-- vim-maximizer
remap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

-- nvim-tree
remap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- Remove all console logs (javascript)
remap.set("n", "<leader>xc", ":g/console.lo/d<CR>", { desc = "Remove all console.log" })
