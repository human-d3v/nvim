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
	{"Tsuzat/NeoSolarized.nvim", lazy = false, priority = 1000, config = {}},
	--lsp configuration
	{"neovim/nvim-lspconfig"},
	{"hrsh7th/cmp-nvim-lsp"},
	{"hrsh7th/nvim-cmp"},
	{"L3MON4D3/LuaSnip", version  = 'v2.*', build = "make install_jsregexp",
		dependencies = {'saadparwaiz1/cmp_luasnip', 'rafamadriz/friendly-snippets'}},
	{'williamboman/mason.nvim'},
	{'williamboman/mason-lspconfig.nvim'},
	--for R programming
	{"R-nvim/R.nvim", lazy = true, ft = {'r','rmd','rnoweb'}},
	{"R-nvim/cmp-r", lazy = true, ft = {'r','rmd','rnoweb'}},
	--for Rust
	{'mrcjkb/rustaceanvim',lazy = true, version = '^5',ft = {'rust'},},
	--rust debugging
	{'mfussenegger/nvim-dap'},
	--for quick commenting
	--kitty conf files syntax highlighting
	{'fladson/vim-kitty', ft = {'kitty'}, lazy = true},
	--markdown preview
	{"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function() vim.fn["mkdp#util#install"]() end,
	},
	--Stata syntax highlighting
	'poliquin/stata-vim',
	--ai auto completion with codeium
	{"Exafunction/codeium.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp"},
	   config = function()
	   	require("codeium").setup({})
	 end},
		--  {
		--     "zbirenbaum/copilot.lua",
		--     cmd = "Copilot",
		--     event = "InsertEnter",
		-- },
		--  {
		--     "zbirenbaum/copilot-cmp",
		--     config = function()
		--         require("copilot_cmp").setup()
		--     end,
		-- },
		{
		  "jackMort/ChatGPT.nvim",
		    event = "VeryLazy",
		    config = function()
		      require("chatgpt").setup()
		    end,
		    dependencies = {
		      "MunifTanjim/nui.nvim",
		      "nvim-lua/plenary.nvim",
		      "folke/trouble.nvim",
		      "nvim-telescope/telescope.nvim"
		    }
		},
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
		ft = {'css', 'html', 'markdown'},
		lazy = true,
	},
	{'Saecki/crates.nvim', event = {'BufRead Cargo.toml'}, 
		opts = {
			completion = {
				cmp = {enable = true},
			},
		}
	},
	--{"vhyrro/luarocks.nvim", priority = 1001, opts = { rocks = {"magick"}}}, -- not necessary for neovim 11+
	--{"3rd/image.nvim", dependencies = {"luarocks.nvim"}, config = function() end},
	{
		'human-d3v/stata-nvim', branch = 'package_split', ft = {'stata'},
		build = 'git pull origin packaging && cd lsp-server && npm init -y && npm install && bun build ./server/src/server.ts --compile --outfile server_bin && cd ..',
		opts = {},
		config = function ()
			require("stata-nvim")
		end,
		event = 'VeryLazy',
		dependencies = {"human-d3v/term-repl.nvim"}
	},
	{'human-d3v/term-repl.nvim', ft = {'javascript', 'stata', 'python'}}
}


require("lazy").setup(plugins, {})
