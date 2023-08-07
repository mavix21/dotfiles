--local jdtls_dir = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local jdtls_dir = "/usr/share/java/jdtls"
local config_dir = jdtls_dir .. "/config_linux"
local plugins_dir = jdtls_dir .. "/plugins"
local path_to_jar = plugins_dir .. "/org.eclipse.equinox.launcher_1.6.500.v20230622-2056.jar"
local path_to_lombok = jdtls_dir .. "/lombok.jar"

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == nil then
	print("root_dir not found!")
	return
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/" .. project_name
os.execute("mkdir -p " .. workspace_dir)

-- JDK path
local jdk_dir = "/usr/lib/jvm/java-20-openjdk/"

--Main Config
local config = {
	cmd = {
		-- 💀
		"java", -- or '/path/to/java17_or_newer/bin/java'

		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.level=ALL",
		"-Xmx1G",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",

		-- 💀
		"-jar",
		path_to_jar,
		-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		-- Must point to the
		-- eclipse.jdt.ls installation

		-- 💀
		"-configuration",
		config_dir,
		-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
		-- Must point to the                      Change to one of `linux`, `win` or `mac`
		-- eclipse.jdt.ls installation            Depending on your system.

		-- 💀
		-- See `data directory configuration` section in the README
		"-data",
		workspace_dir,
	},

	root_dir = root_dir,

	settings = {
		java = {
			home = jdk_dir,
			eclipse = {
				downloadSources = true,
			},

			configuration = {
				runtimes = {
					name = "JavaSE-20",
					path = jdk_dir,
				},
				updateBuildConfiguration = "interactive",
			},

			implementationsCodeLens = {
				enabled = true,
			},

			signatureHelp = {
				enabled = true,
			},

			references = {
				includeDecompiledSources = true,
			},

			referencesCodeLens = {
				enabled = true,
			},

			format = {
				enabled = true,
				settings = {
					url = vim.fn.stdpath("config") .. "/utils/intellij-java-google-style.xml",
					profile = "GoogleStyle",
				},
			},
		},
	},

	signatureHelp = {
		enabled = true,
	},

	completion = {
		importOrder = {
			"java",
			"javax",
			"com",
			"org",
		},
	},

	sources = {
		organizeImports = {
			starThreshold = 9999,
			staticStarThreshold = 9999,
		},
	},

	codeGeneration = {
		toString = {
			template = "${object.className}(${member.name()}=${member.value}, ${otherMembers})",
		},
		useBlocks = true,
	},
}

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
	--keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
	keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
end

config["on_attach"] = on_attach

require("jdtls").start_or_attach(config)
