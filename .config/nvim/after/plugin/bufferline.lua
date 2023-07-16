local buff_status, bufferline = pcall(require, "bufferline")
if not buff_status then
	return
end

bufferline.setup({
	options = {
		separator_style = "thin",
	},
})
