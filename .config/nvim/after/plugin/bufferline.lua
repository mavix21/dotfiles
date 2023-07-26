local buff_status, bufferline = pcall(require, "bufferline")
if not buff_status then
	return
end

bufferline.setup({
	options = {
		mode = "tabs",
		separator_style = "slant",
		always_show_bufferline = false,
		show_buffer_close_icons = false,
		show_close_icon = false,
		color_icons = true,
	},
})

vim.api.nvim_set_keymap("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", {})
vim.api.nvim_set_keymap("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", {})
