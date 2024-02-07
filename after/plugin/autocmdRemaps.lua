--this file contains filetype specific remaps
vim.api.nvim_create_autocmd("FileType", {
	pattern = {"r", "rnoweb"},
	callback = function ()
		vim.schedule(function ()
			vim.keymap.set("i", ">", " %>% ", {buffer = true})
			vim.keymap.set("i", ">>", ">", {buffer = true})
			vim.keymap.set("i", "in ", "%in%", {buffer = true})
		end)
	end,
})

--for JS and TS
vim.api.nvim_create_autocmd("FileType", {
	pattern = {"js", "ts", "javascript", "typescript"},
	callback = function ()
		vim.schedule(function ()
			vim.keymap.set("i", ">", "=>", {buffer = true})
			vim.keymap.set("i", ">>", ">", {buffer = true})
		end)
	end,
})

--for the rusty-boi
vim.api.nvim_create_autocmd("FileType", {
	pattern = {"rust", "rs", "Rust"},
	callback = function ()
		vim.schedule(function ()
		vim.keymap.set("i", ">", "=>", {buffer = true})
		vim.keymap.set("i", ">>", ">", {buffer = true})
		vim.keymap.set("i", "-", "->", {buffer = true})
		vim.keymap.set("i", "--", "-", {buffer = true})
		vim.keymap.set("n", "<leader>rr", ":RustRun<CR>",{buffer = true})
		end)
	end,
})

