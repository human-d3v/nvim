function OpenBufferTerminalInStata()
	vim.api.nvim_exec('new | term', false)
	local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_chan_send(vim.api.nvim_buf_get_option(bufnr, 'channel'), 'stata-mp' .. "\r")
end


function SendVisToStata(isVis)
	local txt = ''
	if isVis == true then
		vim.cmd('normal! gv"xy') --captures vis selection
		txt = vim.fn.getreg('x')
	else
		txt = vim.api.nvim_get_current_line()
	end

	local term_buf = nil
	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if vim.bo[bufnr].buftype == 'terminal' then
			term_buf = bufnr
			break
		end
	end
	if term_buf == nil then
		print("No terminal found.")
		return
	end

	vim.api.nvim_chan_send(vim.api.nvim_buf_get_option(term_buf, 'channel'), txt .. '\r')
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = {"do", "ado", "dct"},
	callback = function ()
		vim.schedule(function ()
			vim.keymap.set("n", "<leader>mp", [[:lua OpenBufferTerminalInStata()<CR>]], {noremap=true, buffer=true})
			vim.keymap.set({"v","x"}, "<leader>t", [[:lua SendVisToStata(true)<CR>]], {noremap=true, buffer=true})
			vim.keymap.set("n", "<leader>t", [[:lua SendVisToStata(false)<CR>]], {noremap=true, buffer=true})
		end)
	end,
})

