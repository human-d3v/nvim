return {
	{
		{
			"hrsh7th/nvim-cmp",
			lazy = false,
			priority = 100,
			dependencies = {
				"onsails/lspkind.nvim", -- maybe on this one
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-nvim-lsp-signature-help",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-buffer",
				{"L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp"},
				"saadparwaiz1/cmp_luasnip",
			},
			config = function ()
				require('config.custom.completion')			
			end
		},
	}
}
