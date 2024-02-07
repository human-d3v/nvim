function OpenBufferTerminal()
	vim.api.nvim_exec('new | term', false)
	local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_chan_send(vim.api.nvim_buf_get_option(bufnr, 'channel'), 'stata-mp' .. "\r")
end


vim.api.nvim_create_autocmd("FileType", {
	pattern = {"do", "ado", "dct"},
	callback = function ()
		vim.schedule(function ()
			vim.keymap.set("n", "<leader>mp", [[:lua OpenBufferTerminal()<CR>]], {noremap=true, buffer=true})
		end)
	end,
})


