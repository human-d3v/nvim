local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function ()
	builtin.grep_string({search = vim.fn.input(":Grep > ") })
end)


local telescope = require('telescope')

telescope.setup({
	defaults = {},
	pickers = {},
	extensions = {
		extension_name = {
			fd = true,
		}
	}
})
