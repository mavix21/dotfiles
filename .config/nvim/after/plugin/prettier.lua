local prettier_status, prettier = pcall(require, "prettier")
if not prettier_status then
	return
end

prettier.setup({
	cli_options = {
		indent_size = 4,
	},
})
