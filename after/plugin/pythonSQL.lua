vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.schedule(function()
			vim.keymap.set("n", "<leader>sql", [[:lua OpenBufferTerminalRepl('py')<CR>]] , {noremap = true, buffer = true})
			vim.keymap.set({"v","x"}, "<Bslash>d", [[:lua SendToRepl(1)<CR>]], {noremap=true, buffer=true})
			vim.keymap.set("n", "<Bslash>d", [[:lua SendToRepl(0)<CR>]], {noremap=true, buffer=true})
			vim.keymap.set("n", "<Bslash>aa", [[:lua SendToRepl(2)<CR>]], {noremap=true, buffer=true})
		end)
	end,
})
