return {
	{'nvim-treesitter/nvim-treesitter', build = ':TSUpdate',
	config = function ()
		require('nvim-treesitter.configs').setup({
		  -- A list of parser names, or "all" (the five listed parsers should always be installed)
		  ensure_installed = { "c", "lua", "vim", "vimdoc", "query","typescript",
													"javascript","python","r","rnoweb", "markdown",
													"markdown_inline", "yaml", "latex", "csv"},
		
		  -- Install parsers synchronously (only applied to `ensure_installed`)
		  sync_install = false,
		
		  -- set to false if you don't have `tree-sitter` CLI installed locally
		  auto_install = true,
		
		  highlight = {
		    enable = true,
		    additional_vim_regex_highlighting = false,
		  },
		})
	end
	},
}
