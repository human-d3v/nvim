local function R_in_Pipe()
	local line = vim.api.nvim_get_current_line()
	if string.sub(line,1,1) == "#" then
		return "in "
	else
		return " %in% "
	end
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = {"r", "rnoweb","rmd"},
	callback = function ()
		vim.schedule(function ()
			vim.keymap.set('t','<leader>mv', ":lua ResizeAndMove(80)<CR>", {buffer = true})
			vim.keymap.set("i", ">", " %>% ", {buffer = true})
			vim.keymap.set("i", ">>", ">", {buffer = true})
			vim.keymap.set("i", "in ", R_in_Pipe(), {buffer = true})
			vim.keymap.set("i", "`", "```{r}\n\n```", {buffer = true})
			vim.keymap.set("i", "``", "`", {buffer = true})
			vim.keymap.set("i", "_", " <- ", {buffer = false})
			vim.keymap.set("i", "__", "_", {buffer = false})
		end)
	end,
})
