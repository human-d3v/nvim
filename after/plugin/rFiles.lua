vim.api.nvim_create_autocmd("FileType", {
	pattern = {"r", "rnoweb","rmd"},
	callback = function ()
		vim.schedule(function ()
			vim.keymap.set('t','<leader>mv', ":lua ResizeAndMove(80)<CR>", {buffer = true})
			vim.keymap.set("i", ">", " %>% ", {buffer = true})
			vim.keymap.set("i", ">>", ">", {buffer = true})
			vim.keymap.set("i", "<C-->", "<Plug>RAssign", {buffer = true, silent = true}) -- reassign keymap for assignment
			require('cmp').setup({sources = {{ name = "cmp_r" }}})
			require('cmp_r').setup({})
		end)
	end
})
