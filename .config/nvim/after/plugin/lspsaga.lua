-- import lspsaga safely
local saga_status, saga = pcall(require, "lspsaga")
if not saga_status then
	return
end

saga.setup({
	-- keybinds for navigation in lspsaga window
	scroll_preview = { scroll_down = "<C-d>", scroll_up = "<C-u>" },

	-- use enter to open file with definition preview
	definition = {
		edit = "<CR>",
	},

	ui = {
		-- colors = {
		-- 	normal_bg = "#022746",
		-- },
		border = "rounded",
	},

	symbol_in_winbar = {
		enable = false,
	},

	finder = {
		methods = {
			tyd = "textDocument/typeDefinition",
		},
		keys = {
			shuttle = "\\",
		},
		default = "def+imp+ref",
	},

	--[[ diagnostic = {
		diagnostic_only_current = true,
	}, ]]
})

vim.diagnostic.config({
	virtual_text = true,
	update_in_insert = false,
})
