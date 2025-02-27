return {	
	{'poliquin/stata-vim', ft = {'stata'}},
	{
		'human-d3v/stata-nvim', branch = 'main', ft = {'stata'},
		build = 'git pull && cd lsp-server && npm init -y && npm install && bun build ./server/src/server.ts --compile --outfile server_bin && cd ..',
		opts = {},
		config = function ()
			vim.api.nvim_create_autocmd('FileType', {
			  pattern = 'stata',
			  callback = function()
					local stata = require('stata-nvim')
			    stata.setup({dev = false})
			  end,
			})
		end,
		event = 'VeryLazy',
		dependencies = {"human-d3v/term-repl.nvim"}
	},
	{'human-d3v/term-repl.nvim', ft = {'javascript', 'stata', 'python'}, opts = {}},
}
