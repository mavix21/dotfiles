function ColorMyPencils(color)
	--color = color or "tokyonight-night"
	--color = color or "doom-one"
	--color = color or "catppuccin"
	color = color or "onedark"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	--vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	--vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
	--vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
end

ColorMyPencils()
