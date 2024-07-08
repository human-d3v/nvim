vim.api.nvim_create_autocmd("FileType", {
	pattern = {"stata"},
	callback = function ()
		vim.schedule(function ()
			vim.keymap.set("n", "<leader>mp", [[:lua OpenBufferTerminalRepl('stata-mp')<CR>]], {noremap=true, buffer=true})
			vim.keymap.set({"v","x"}, "<BSlash>d", [[:lua SendToRepl(1)<CR>]], {noremap=true, buffer=true})
			vim.keymap.set("n", "<BSlash>d", [[:lua SendToRepl(0)<CR>]], {noremap=true, buffer=true})
			vim.keymap.set("n", "<BSlash>aa", [[:lua SendToRepl(2)<CR>]], {noremap=true, buffer=true})
		end)
	end,
})
