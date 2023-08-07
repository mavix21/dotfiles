local onedark_status, onedark = pcall(require, "onedark")
if not onedark_status then
	return
end

onedark.setup({
	-- Main options --
	style = "dark", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
	transparent = false, -- Show/hide background
	term_colors = true, -- Change terminal color as per the selected theme style
	ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
	cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

	-- toggle theme style ---
	toggle_style_key = "<leader>ts", -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
	toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer" }, -- List of styles to toggle between

	-- Change code style ---
	-- Options are italic, bold, underline, none
	-- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
	code_style = {
		comments = "italic",
		keywords = "bold",
		functions = "none",
		strings = "none",
		variables = "none",
	},

	-- Lualine options --
	lualine = {
		transparent = false, -- lualine center bar transparency
	},

	-- Custom Highlights --
	colors = {
		violet = "#A9A1E1",
		pink = "#FFA8FF",
		sky = "#46D9FF",
		--cyan = "#73DACA",
		fg_alt = "#C0CAF5",
		--dark_pink = "#F36BA5",
		dark_pink = "#E863B2",
		--dark_violet = "#c5a8ff",
	}, -- Override default colors

	highlights = {
		["@text.title"] = { fg = "$violet", fmt = "bold" },
		-- ["@text.literal"] = { fg = "$grey" },
		["@text.literal.block.markdown"] = { fg = "$blue", fmt = "bold" },
		-- ["@keyword"] = { fg = "$blue" },
		-- ["@keyword.function"] = { fg = "$blue" },
		-- ["@keyword.operator"] = { fg = "$blue" },
		-- ["@conditional"] = { fg = "$blue" },
		-- ["@function"] = { fg = "$purple" },
		-- ["@function.builtin"] = { fg = "$pink" },
		-- ["@operator"] = { fg = "$blue" },
		["@punctuation"] = { fg = "$blue" },
		["@punctuation.delimiter"] = { fg = "$blue" },
		["@punctuation.bracket"] = { fg = "$blue" },
		["@punctuation.special"] = { fg = "$blue" },
		-- ["@variable.builtin"] = { fg = "$purple", fmt = "bold" },
		-- ["@label"] = { fg = "$blue" },
		-- ["@parameter"] = { fg = "$pink" },
		-- ["@method"] = { fg = "$purple" },
		-- ["@variable"] = { fg = "$fg_alt" },
		-- ["@property"] = { fg = "$violet" },
		-- ["@lsp.type.variable"] = { fg = "$fg_alt" },
		-- ["@lsp.type.parameter"] = { fg = "$dark_pink" },
	}, -- Override highlight groups

	-- Plugins Config --
	diagnostics = {
		darker = false, -- darker colors for diagnostic
		undercurl = true, -- use undercurl instead of underline for diagnostics
		background = false, -- use background color for virtual text
	},
})

onedark.load()

-- overrides CursorLine after theme is loaded
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#21242B" })
--vim.api.nvim_set_hl(0, "Function", { fg = "#A9A1E1" })
