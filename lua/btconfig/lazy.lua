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
    {'nvim-telescope/telescope.nvim', tag = '0.1.2',--nvim telescope. works as a fuzzy finder 
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
		-- 'NLKNguyen/papercolor-theme',
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

		{'abecodes/tabout.nvim',
			config = function ()
				require('tabout').setup{
					tabkey = '<Tab>', -- key to trigger tabout, set to an empty string to disable
					backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
			   act_as_tab = true, -- shift content if tab out is not possible
		  	 act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
				 default_tab = '<C-t>', -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
				 default_shift_tab = '<C-d>', -- reverse shift default action,
				 enable_backwards = true, -- well ...
				 completion = true, -- if the tabkey is used in a completion pum
				 tabouts = {
					{open = "'", close = "'"},
					{open = '"', close = '"'},
					{open = '`', close = '`'},
					{open = '(', close = ')'},
					{open = '[', close = ']'},
					{open = '{', close = '}'}
				},
				ignore_beginning = false, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
				exclude = {} -- tabout will ignore these filetypes
			}
			end,
				dependencies = {'nvim-treesitter', -- or require if not used so far
				 'nvim-cmp'} ,-- if a completion plugin is using tabs load it before
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
		--colorscheme
		{
			'GustavoPrietoP/doom-themes.nvim'
		},
		--kitty conf files syntax highlighting
		'fladson/vim-kitty',
		--markdown preview

		{
			"iamcco/markdown-preview.nvim",
			cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
			ft = { "markdown" },
			build = function() vim.fn["mkdp#util#install"]() end,
		}
}


require("lazy").setup(plugins, {})
