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
    {'nvim-telescope/telescope.nvim', tag = '0.1.5',--nvim telescope. works as a fuzzy finder 
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
		{"folke/trouble.nvim", dependencies={"nvim-tree/nvim-web-devicons"},opts = {}},
		-- 'NLKNguyen/papercolor-theme',
		{"Tsuzat/NeoSolarized.nvim",
			lazy = false,
			priority = 1000,
			config = {}
		},
		{'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
		('nvim-treesitter/playground'),
		('nvim-lua/plenary.nvim'),
		('ThePrimeagen/harpoon'),
		('mbbill/undotree'),
		('tpope/vim-fugitive'), --allows you to navigate a git repo and track changes
		{'VonHeikemen/lsp-zero.nvim',
			branch = 'v2.x',
			dependencies = {
				--LSP support		
				{'neovim/nvim-lspconfig'},
				{'williamboman/mason.nvim',
					build = function()
						pcall(vim.cmd, 'MasonUpdate')
					end},
				{'williamboman/mason-lspconfig.nvim'}, --optional

				--autocompletion
					{'hrsh7th/nvim-cmp'},			-- required
					{'hrsh7th/cmp-buffer'},
					{'hrsh7th/cmp-path'},
					{'saadparwaiz1/cmp_luasnip'},
					{'hrsh7th/cmp-nvim-lsp'},	-- required
					{'hrsh7th/cmp-nvim-lua'},

					--snippets
					{'L3MON4D3/LuaSnip'},			-- required
					{'rafamadriz/friendly-snippets'},
			}
		},
		'rstacruz/vim-closer',
		"mfussenegger/nvim-dap",
		{ "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} },

		--for R programming
			'jalvesaq/Nvim-R',
			'gaalcaras/ncm-R',
		--for Rust
			'neovim/nvim-lspconfig',
			{
				'mrcjkb/rustaceanvim',
				version = '^3',
				ft = {'rust'},
			},
			--rust debugging
				'mfussenegger/nvim-dap',
		--for quick commenting
		{
			'numToStr/Comment.nvim',
			opts = {},
			lazy = false,
		},
		--kitty conf files syntax highlighting
		'fladson/vim-kitty',
		--markdown preview

		{
			"iamcco/markdown-preview.nvim",
			cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
			ft = { "markdown" },
			build = function() vim.fn["mkdp#util#install"]() end,
		},
		--Stata syntax highlighting
		'poliquin/stata-vim',
		--ai auto completion with codeium
		{
			"Exafunction/codeium.nvim",
			dependencies = {
    	    "nvim-lua/plenary.nvim",
    	    "hrsh7th/nvim-cmp",
    	},
    	config = function()
    	    require("codeium").setup({
    	    })
    	end
		},
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
			end
		}
}


require("lazy").setup(plugins, {})
