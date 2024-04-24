function OpenBufferTerminalRepl(opt)
	-- vim.api.nvim_exec('new | term', false)
	vim.api.nvim_exec('belowright split | term', false)
	local bufnr = vim.api.nvim_get_current_buf()
	vim.g.terminal_buffer = bufnr
  vim.api.nvim_chan_send(vim.api.nvim_buf_get_option(bufnr, 'channel'), opt .. "\r")
end


function SendToRepl(opt)
	--0: send the current line to Stata
	--1: send the visual selection to Stata
	--2: send the entire file up to and including the current line to Stata
	local txt = ''
	if opt == 1 then
		vim.cmd('normal! gv"xy') --captures vis selection
		txt = vim.fn.getreg('x')
	elseif opt == 2 then
		local ln, _  = unpack(vim.api.nvim_win_get_cursor(0))
		local lnTxts = vim.api.nvim_buf_get_lines(vim.api.nvim_get_current_buf(), 0, ln, false)
		txt = table.concat(lnTxts, "\n")
		-- txt = lnTxts
	else
		txt = vim.api.nvim_get_current_line()
	end
	
	--move cursor to next non-empty line
	-- local empty_line_pattern = '^%s*$'
	local empty_or_comment_line = "'^\\s*\\*|^\\s*$'"
	local cur_line = vim.api.nvim_get_current_line()
	vim.cmd('normal! j') --move down one line before check
	while true do
		if empty_or_comment_line:match(cur_line) then
			vim.cmd('normal! j')
		else
			break
		end
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
	if string.match(string.lower(txt), "%f[%a]use%f[%A]") then 
		vim.api.nvim_chan_send(vim.api.nvim_buf_get_option(term_buf, 'channel'), txt .. '\r')
		vim.api.nvim_chan_send(vim.api.nvim_buf_get_option(term_buf, 'channel'), "describe" .. '\r')
		-- vim.api.nvim_command("lua StataGlobalEnv()")
	else
		vim.api.nvim_chan_send(vim.api.nvim_buf_get_option(term_buf, 'channel'), txt .. '\r')
	end
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = {"stata"},
	callback = function ()
		vim.schedule(function ()
			vim.keymap.set("n", "<leader>mp", [[:lua OpenBufferTerminalRepl('stata-mp')<CR>]], {noremap=true, buffer=true})
			vim.keymap.set({"v","x"}, "<BSlash>d", [[:lua SendToRepl(1)<CR>]], {noremap=true, buffer=true})
			vim.keymap.set("n", "<BSlash>d", [[:lua SendToRepl(0)<CR>]], {noremap=true, buffer=true})
			vim.keymap.set("n", "<BSlash>aa", [[:lua SendToRepl(2)<CR>]], {noremap=true, buffer=true})
		end)
	end,
})

