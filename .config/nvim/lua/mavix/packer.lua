-- Autoinstall packer if not installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- Autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost packer.lua source <afile> | PackerSync
	augroup end
]])

-- Import packer safely
local status, packer = pcall(require, "packer")
if not status then
	return
end

-- Add list of plugins to install
return packer.startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- managing & installing lsp servers
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")

	-- Colorschemes
	use("folke/tokyonight.nvim")
	use({
		"NTBBloodbath/doom-one.nvim",
		setup = function()
			vim.g.doom_one_cursor_coloring = true
			vim.g.doom_one_diagnostics_text_color = true
			vim.g.doom_one_plugin_neorg = true
			vim.g.doom_one_plugin_telescope = true
			vim.g.doom_one_plugin_lspsaga = true
		end,
	})

	use({
		"navarasu/onedark.nvim",
		setup = {
			style = "darker",
		},
	})

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		-- or                            , branch = '0.1.x',
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })

	use("christoomey/vim-tmux-navigator")

	use("szw/vim-maximizer")

	-- essential plugins
	use("tpope/vim-surround")
	use("numToStr/Comment.nvim")

	use("vim-scripts/ReplaceWithRegister")

	-- status line
	use("nvim-lualine/lualine.nvim")

	-- nvim tree
	use("nvim-tree/nvim-tree.lua")

	use("kyazdani42/nvim-web-devicons")

	-- autocompletion
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")

	-- snippets
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")
	use("rafamadriz/friendly-snippets")

	-- configuring lsp servers
	use("neovim/nvim-lspconfig")
	use("hrsh7th/cmp-nvim-lsp")
	use({ "glepnir/lspsaga.nvim", branch = "main" })
	use("onsails/lspkind.nvim") -- vscode-like pictograms
	use("joe-re/sql-language-server")

	-- formatting & linting
	use("jose-elias-alvarez/null-ls.nvim")
	use("jayp0521/mason-null-ls.nvim")
	use("MunifTanjim/prettier.nvim")

	-- auto closing
	use("windwp/nvim-autopairs")
	use("windwp/nvim-ts-autotag")

	-- git signs plugin
	use("lewis6991/gitsigns.nvim")

	-- database managment
	use("tpope/vim-dadbod")
	use("kristijanhusak/vim-dadbod-ui")

	-- buffer line
	use("akinsho/bufferline.nvim")

	-- neorg
	use({
		"nvim-neorg/neorg",
		run = ":Neorg sync-parsers",
	})

	-- which key
	use({
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
	})

	-- show indent lines
	use("lukas-reineke/indent-blankline.nvim")

	-- colorizer
	use("NvChad/nvim-colorizer.lua")

	-- notifications
	use("rcarriga/nvim-notify")

	-- documentation generator
	use({
		"kkoomen/vim-doge",
		run = ":call doge#install()",
	})

	-- java
	use("mfussenegger/nvim-jdtls")

	if packer_bootstrap then
		require("packer").sync()
	end
end)
