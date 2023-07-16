vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_show_database_icon = 1
vim.g.db_ui_force_echo_notifications = 1

vim.g.db_ui_table_helpers = {
	mysql = {
		Count = "SELECT COUNT(1) FROM {optional_schema}{table}",
		Explain = "EXPLAIN {last_query}",
	},
}

vim.g.db_ui_icons = {
	expanded = {
		db = "▾ ",
		buffers = "▾ ",
		saved_queries = "▾ ",
		schemas = "▾ ",
		schema = "▾ פּ",
		tables = "▾ 藺",
		table = "▾ ",
	},
	collapsed = {
		db = "▸ ",
		buffers = "▸ ",
		saved_queries = "▸ ",
		schemas = "▸ ",
		schema = "▸ פּ",
		tables = "▸ 藺",
		table = "▸ ",
	},
	saved_query = "",
	new_query = "璘",
	tables = "離",
	buffers = "﬘",
	add_connection = "",
	connection_ok = "✓",
	connection_error = "✕",
}

-- opens dbui
vim.keymap.set("n", "<leader>db", ":tab DBUI<CR>")

-- just close the tab, but context related to the keybindings
vim.keymap.set("n", "<leader>tq", ":tabclose<CR>")
