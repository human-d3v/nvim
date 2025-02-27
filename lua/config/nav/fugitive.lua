return {
	{'tpope/vim-fugitive',
		config = function ()
			vim.keymap.set('n', '<leader>gs',vim.cmd.Git);
		end
	}, --allows you to navigate a git repo and track changes
}
