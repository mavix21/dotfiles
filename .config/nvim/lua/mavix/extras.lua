local function insert_space_after_curly_brace()
	local cur_pos = vim.api.nvim_win_get_cursor(0)
	local line = vim.api.nvim_get_current_line()
	local char_before_cursor = line:sub(cur_pos - 1, cur_pos)

	if char_before_cursor == "{" then
		vim.api.nvim_insert_char(0, " ")
	end
end

vim.api.nvim_set_keymap("i", "{", "lua insert_space_after_curly_brace()", { noremap = true })
