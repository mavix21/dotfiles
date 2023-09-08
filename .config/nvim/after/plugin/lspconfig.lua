-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

-- import cmp-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end

local protocol = require("vim.lsp.protocol")

local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })
local enable_format_on_save = function(_, bufnr)
	vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = augroup_format,
		buffer = bufnr,
		callback = function()
			vim.lsp.buf.format({ bufnr = bufnr })
		end,
	})
end

-- enable keybinds only when lsp server available
local on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true }
	local keymap = vim.keymap

	keymap.set("n", "<C-j><C-e>", function()
		require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
	end)
	keymap.set("n", "<C-k><C-e>", function()
		require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
	end)
	keymap.set("n", "<C-j><C-j>", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in current buffer
	keymap.set("n", "<C-k><C-k>", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in current buffer
	keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references
	keymap.set("n", "gf", "<cmd>Lspsaga finder<CR>", opts) -- show definition, references
	keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "go to declaration" }, opts) -- go to declaration
	keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
	keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- go to implementation
	keymap.set("n", "gI", vim.lsp.buf.implementation, opts) -- go to implementation
	keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- go to implementation
	keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
	keymap.set("n", "gr", "<cmd>Lspsaga rename ++project<CR>", opts) -- smart rename
	keymap.set("n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
	keymap.set("n", "gc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
	keymap.set("n", "gT", "<cmd>Lspsaga goto_type_definition<CR>", opts)
	--keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer
	--keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to previous diagnostic in buffer
	--keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
	keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor

	-- if client.supports_method("textDocument/semanticTokens") then
	-- 	client.server_capabilities.semanticTokensProvider = nil
	-- end
end

-- used to enable autocompletion (assign to every lsp config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- set border for :LspInfo
require("lspconfig.ui.windows").default_options = {
	border = "single",
}

-- configure html server
lspconfig.html.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure css server
lspconfig["cssls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure emmet language server
lspconfig["emmet_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = {
		"html",
		"typescriptreact",
		"javascriptreact",
		"css",
		"sass",
		"scss",
		"less",
		"svelte",
		"astro",
	},
})

-- configure lua server (with special settings)
lspconfig["lua_ls"].setup({
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		enable_format_on_save(client, bufnr)
	end,
	settings = { -- custom settings for lua
		Lua = {
			-- make the language server recognize "vim" global
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				-- make language server aware of runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

-- configure pylsp server
lspconfig.pylsp.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- configure pyright server
lspconfig.pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- configure clangd server
lspconfig["clangd"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure r-languageserver server
lspconfig["r_language_server"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure sql server
lspconfig["sqlls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["gopls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure eslint lsp server
lspconfig.eslint.setup({
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		client.server_capabilities.document_formatting = true

		-- Format document on save
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
	end,
	settings = {
		format = { enable = true },
	},
})

lspconfig.tsserver.setup({
	on_attach = on_attach,
	filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
	cmd = { "typescript-language-server", "--stdio" },
})

lspconfig.solidity_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.astro.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.tailwindcss.setup({})
