-- vscode icons
local cmp_kinds = {
	Text = " ",
	Method = " ",
	Function = " ",
	Constructor = " ",
	Field = " ",
	Variable = " ",
	Class = " ",
	Interface = " ",
	Module = " ",
	Property = " ",
	Unit = " ",
	Value = " ",
	Enum = " ",
	Keyword = " ",
	Color = " ",
	Snippet = " ",
	File = " ",
	Reference = " ",
	Folder = " ",
	EnumMember = " ",
	Constant = " ",
	Struct = " ",
	Event = " ",
	Operator = " ",
	TypeParameter = " ",
}

local function border(hl_name)
	return {
		{ "╭", hl_name },
		{ "─", hl_name },
		{ "╮", hl_name },
		{ "│", hl_name },
		{ "╯", hl_name },
		{ "─", hl_name },
		{ "╰", hl_name },
		{ "│", hl_name },
	}
end

local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
	return
end

local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
	return
end

local lspkind_status, lspkind = pcall(require, "lspkind")
if not lspkind_status then
	return
end

-- load friendly-snippets
require("luasnip/loaders/from_vscode").lazy_load()

cmp.setup({
	completion = {
		completeopt = "menu,menuone",
	},

	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},

	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping(function(fallback)
			-- confirm with tab, if no entry selected, will confirm the first item
			if cmp.visible() then
				local entry = cmp.get_selected_entry()
				if not entry then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
				else
					cmp.confirm()
				end
			else
				fallback()
			end
		end, { "i", "s", "c" }),
	},

	sources = cmp.config.sources({
		{ name = "nvim_lsp" }, -- lsp
		{ name = "luasnip" }, -- snippets
		{ name = "buffer" }, -- text within current buffer
		{ name = "path" }, -- file system paths
	}),

	formatting = {
		fields = { "abbr", "kind", "menu" },
		mode = "symbol",
		format = function(_, vim_item)
			--vim_item.kind = string.format(" %s %s", cmp_kinds[vim_item.kind], vim_item.kind)
			vim_item.kind = cmp_kinds[vim_item.kind] .. " " .. vim_item.kind
			return vim_item
		end,
	},

	window = {
		completion = {
			border = border("CmpBorder"),
			scrollbar = false,
		},

		documentation = {
			border = border("CmpDocBorder"),
			winhighlight = "Normal:CmpDoc",
		},
	},
})

-- Highlight groups for Pmenu and Cmp
vim.api.nvim_set_hl(0, "CmpDoc", { bg = "#202328" })
vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#98BE65", fg = "#282c34", bold = true })
vim.api.nvim_set_hl(0, "Pmenu", { fg = "#DFDFDF", bg = "#202328" })

vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#DFDFDF", bg = "NONE", strikethrough = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#46D9FF", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#46D9FF", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#C792EA", bg = "NONE", italic = true })

vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#DFDFDF", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#FF6C6B", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = "#DFDFDF", bg = "NONE" })

vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#98BE65", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#98BE65", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#DFDFDF", bg = "NONE" })

vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#DA8548", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#ECBE7B", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#ECBE7B", bg = "NONE" })

vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#FFA8FF", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = "#51AFEF", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#4DB5BD", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#ECBE7B", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#EADFF0", bg = "NONE" })

vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#51AFEF", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#C5CDD9", bg = "NONE" })

vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#FF6C6B", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#FF6C6B", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = "#FF6C6B", bg = "NONE" })

vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#FFA8FF", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = "#DFDFDF", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = "#DFDFDF", bg = "NONE" })

vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#DFDFDF", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = "#DFDFDF", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#DFDFDF", bg = "NONE" })
