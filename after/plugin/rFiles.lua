vim.api.nvim_create_autocmd("FileType", {
	pattern = {"r", "rnoweb","rmd"},
	callback = function ()
		vim.schedule(function ()
			vim.keymap.set('t','<leader>mv', ":lua ResizeAndMove(80)<CR>", {buffer = true})
			vim.keymap.set("i", "<C-.>", " %>% ", {buffer = true})
			vim.keymap.set("i", "<C-->", "<Plug>RInsertAssign", {buffer = true, silent = true}) -- reassign keymap for assignment
			vim.keymap.set("n", "<leader>br", function ()
				local line_num = vim.api.nvim_win_get_cursor(0)[1]
				vim.api.nvim_buf_set_lines(0, line_num, line_num, false, {"# " .. string.rep("~", 77)})
			end, {buffer = true, silent = true})
		end)
	end
})

require('cmp').setup({sources = {
	{ name = "nvim_lsp" },
	-- { name = "codeium" }, 
	{ name = "luasnip" },
	{ name = "nvim_lsp_signature_help" },
	{ name = "buffer" },
}})
