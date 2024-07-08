vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.schedule(function()
			vim.keymap.set("n", "<leader><leader>py", [[:lua OpenBufferTerminalRepl('py')<CR>]] , {noremap = true, buffer = true})
			vim.keymap.set({"v","x"}, "<Bslash>d", [[:lua SendToRepl(1)<CR>]], {noremap=true, buffer=true})
			vim.keymap.set("n", "<Bslash>d", [[:lua SendToRepl(0)<CR>]], {noremap=true, buffer=true})
			vim.keymap.set("n", "<Bslash>aa", [[:lua SendToRepl(2)<CR>]], {noremap=true, buffer=true})
			vim.keymap.set('n', '<Bslash>n', [[:lua SendToRepl(3, "py")<CR>]], {noremap=true, buffer=true})
			vim.keymap.set('n', '<Bslash>c', [[:lua VerifySendToRepl(3, "exit()")<CR>]], {noremap=true, buffer=true})
		end)
	end,
})
