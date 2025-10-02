local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "

local plugins = {
	{'nvim-lua/plenary.nvim'},
	{'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
  {'nvim-telescope/telescope.nvim', tag = '0.1.6',--nvim telescope. works as a fuzzy finder 
    dependencies = { 'nvim-lua/plenary.nvim' }},
	{'ThePrimeagen/harpoon', branch = 'harpoon2',
		dependencies = {'nvim-lua/plenary.nvim'}},
	{'mbbill/undotree'},
	{'tpope/vim-fugitive'}, --allows you to navigate a git repo and track changes
	{"folke/trouble.nvim", dependencies={"nvim-tree/nvim-web-devicons"},opts = {}},
	-- {"Tsuzat/NeoSolarized.nvim", lazy = false, priority = 1000, config = {}},
	-- {"Shatur/neovim-ayu"},
	 {"dasupradyumna/midnight.nvim", lazy=false, priority=1000},
	--lsp configuration
	{"neovim/nvim-lspconfig"},
	{"hrsh7th/nvim-cmp"},
	{"hrsh7th/cmp-nvim-lsp"},
	{"hrsh7th/cmp-nvim-lsp-signature-help"},
	{"hrsh7th/cmp-path"},
	{"hrsh7th/cmp-buffer"},
	{"onsails/lspkind.nvim"},
	{"L3MON4D3/LuaSnip", version  = 'v2.*', build = "make install_jsregexp",
		dependencies = {'saadparwaiz1/cmp_luasnip'}},
	{'williamboman/mason.nvim'},
	{'williamboman/mason-lspconfig.nvim'},
	--for R programming
	{"R-nvim/R.nvim", lazy = true, ft = {'r','rmd','rnoweb'}},
	{"R-nvim/cmp-r", lazy = true, ft = {'r','rmd','rnoweb'}},
	--for Rust
	{'mrcjkb/rustaceanvim',lazy = true, version = '^5',ft = {'rust'},},
	---- debugging
	{'mfussenegger/nvim-dap'},
	---- crate lookup
	{'Saecki/crates.nvim', 
		event = {'BufRead Cargo.toml'},
		opts = {
			completion = {
				cmp = {enabled = true }, 
				crates = { enabled = true},
			},
			lsp = {
				enabled = true, 
				actions = true, 
				completion = true, 
				hover = true,
			},
		}
	},
	--kitty conf files syntax highlighting
	-- {'fladson/vim-kitty', ft = {'kitty'}, lazy = true},
	--markdown preview
	{"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function() vim.fn["mkdp#util#install"]() end,
	},
	--Stata syntax highlighting
	{'poliquin/stata-vim', ft = {'stata'}},
	--ai integration
	{
		"olimorris/codecompanion.nvim",
		opts = {},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		}
	},
	{"zbirenbaum/copilot.lua", cmd = "Copilot"},
	{"zbirenbaum/copilot-cmp", dependencies = {"zbirenbaum/copilot.lua"},
		opts = {}},
	-- css/markdown/html colorizer
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
		ft = {'css', 'html', 'markdown'},
		lazy = true,
	},
	-- {
	-- 	'human-d3v/stata-nvim', branch = 'main', ft = {'stata'},
	-- 	build = 'git pull && cd lsp-server && npm init -y && npm install && bun build ./server/src/server.ts --compile --outfile server_bin && cd ..',
	-- 	opts = {},
	-- 	config = function ()
	-- 		require("stata-nvim")
	-- 	end,
	-- 	event = 'VeryLazy',
	-- 	dependencies = {"human-d3v/term-repl.nvim"}
	-- },
	{'human-d3v/term-repl.nvim', ft = {'javascript', 'stata', 'python'}, opts = {}},
	-- {dir = "~/Documents/plugins/term-repl.nvim", "term-repl.nvim", opts = {}},
	{
		"human-d3v/txt-files.nvim",
		build = "cd api-caller && bun install && bun run compile",
		opts = {}
	},
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
	},
	{
	  "sphamba/smear-cursor.nvim",
	  opts = {},
	},
	-- for dart development
	{ 'nvim-flutter/flutter-tools.nvim', dependencies = {
				'nvim-lua/plenary.nvim',
				'stevearc/dressing.nvim' --optional for vim.ui.select 
			},
			config = true, ft = {"dart"}, lazy = true, },
	-- toggle-term
	{'akinsho/toggleterm.nvim', version = "*", config = true}
}


require("lazy").setup(plugins, {})
