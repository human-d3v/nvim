--this file contains filetype specific remaps
vim.api.nvim_create_autocmd("FileType", {
	pattern = {"r", "rnoweb","rmd"},
	callback = function ()
		vim.schedule(function ()
			vim.keymap.set("i", ">", " %>% ", {buffer = true})
			vim.keymap.set("i", ">>", ">", {buffer = true})
			vim.keymap.set("i", "in ", "%in%", {buffer = true})
			vim.keymap.set("i", "`", "```{r}\n\n```", {buffer = true})
			vim.keymap.set("i", "``", "`", {buffer = true})
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

-- setting chatgpt useage based on filetype
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"lua", "python", "python3","typescript","javascript","sh"},
	callback = function ()
    vim.keymap.set("n", "<leader>g", ":ChatGPT<CR>",{buffer = true})
  end,
})
