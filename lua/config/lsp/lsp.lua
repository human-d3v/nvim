return {
	{
	{"neovim/nvim-lspconfig",
		lazy = false, 
		dependencies = {
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},
			{'mfussenegger/nvim-dap'},
		},
		config = function ()
			require("config.custom.lsp_config")
		end
	},
	},
}
