--this file contains filetype specific remaps
--for JS and TS
vim.api.nvim_create_autocmd("FileType", {
	pattern = {"js", "ts", "javascript", "typescript"},
	callback = function ()
		vim.schedule(function ()
			vim.keymap.set("i", "<C-.>", "=>", {buffer = true})
		end)
	end,
})


vim.api.nvim_create_autocmd("FileType", {
	pattern = {"py", "python"},
	callback = function ()
		vim.schedule(function ()
			vim.keymap.set("i", "<C-->", "->", {buffer = true})
		end)
	end,
})
