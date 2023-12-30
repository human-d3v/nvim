function LineBreak()
	local lineNum = vim.api.nvim_win_get_cursor(0)[1]
	local win = vim.api.nvim_get_current_win()
	local br = string.rep("~", 79)
	vim.api.nvim_buf_set_lines(0, lineNum, lineNum, false, {br})
	vim.api.nvim_win_set_cursor(win, {lineNum + 1, 0})
end
