local opts = {noremap = true, buffer = true}

vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.schedule(function()
			vim.keymap.set("n", "<leader><leader>py", [[:lua OpenBufferTerminalRepl('py')<CR>]] , opts)
			vim.keymap.set({"v","x"}, "<Bslash>d", [[:lua SendToRepl('python', 1)<CR>]], opts)
			vim.keymap.set("n", "<Bslash>d", [[:lua SendToRepl('python', 0)<CR>]], opts)
			vim.keymap.set("n", "<Bslash>aa", [[:lua SendToRepl('python', 2)<CR>]], opts)
			vim.keymap.set('n', '<Bslash>n', [[:lua SendToRepl('python', 3, "py")<CR>]], opts)
			vim.keymap.set('n', '<Bslash>c', [[:lua VerifySendToRepl('python', 3, "exit()")<CR>]], opts)
			vim.keymap.set('n', '<Bslash>t', [[:lua SendToRepl('term', 0)<CR>]], opts)
			vim.keymap.set({'v','x'}, '<Bslash>t', [[:lua SendToRepl('term', 1)<CR>]], opts)
			vim.keymap.set('n', '<leader>t', [[:lua TempBuffer()<CR>]], opts)
		end)
	end,
})
