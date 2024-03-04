vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.schedule(function()
			vim.keymap.set("n", "<leader>sql", [[:lua OpenBufferTerminalRepl('py')<CR>]] , {noremap = true, buffer = true})
			vim.keymap.set({"v","x"}, "<leader><leader>t", [[:lua SendToRepl(1)<CR>]], {noremap=true, buffer=true})
			vim.keymap.set("n", "<leader><leader>t", [[:lua SendToRepl(0)<CR>]], {noremap=true, buffer=true})
			vim.keymap.set("n", "<leader><leader>at", [[:lua SendToRepl(2)<CR>]], {noremap=true, buffer=true})
		end)
	end,
})
