vim.api.nvim_create_autocmd("FileType", {
	pattern = {"stata"},
	callback = function ()
		vim.schedule(function ()
			vim.keymap.set("n", "<leader>mp", [[:lua OpenBufferTerminalRepl('stata-mp')<CR>]], {noremap=true, buffer=true})
			vim.keymap.set({"v","x"}, "<BSlash>d", [[:lua SendToRepl('stata',1)<CR>]], {noremap=true, buffer=true})
			vim.keymap.set("n", "<BSlash>d", [[:lua SendToRepl('stata',0)<CR>]], {noremap=true, buffer=true})
			vim.keymap.set("n", "<BSlash>aa", [[:lua SendToRepl('stata',2)<CR>]], {noremap=true, buffer=true})
			vim.keymap.set("n", "<Bslash>q", [[:lua VerifyCloseBuffer('stata')<CR>]], {noremap=true, buffer=true})
			vim.keymap.set('n', '<Bslash>rm', [[:lua SendToRepl('stata', 3, "exit")<CR>]], {noremap=true, buffer=true})
			vim.keymap.set('n', '<Bslash>n', [[:lua SendToRepl('stata', 3, "clear\nexit\nstata-mp")<CR>]], {noremap=true, buffer=true})
		end)
	end,
})
