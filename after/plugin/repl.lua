function OpenBufferTerminalRepl(opt)
	-- vim.api.nvim_exec('new | term', false)
	vim.api.nvim_exec2('belowright split | term', {output = true})
	local bufnr = vim.api.nvim_get_current_buf()
	if opt == 'stata-mp' then
		vim.g.stata_repl = bufnr
	elseif opt == 'py' then
		vim.g.python_repl = bufnr
	else 
		vim.term_buf = bufnr
	end
	-- vim.g.term_buf = bufnr
	-- vim.api.nvim_buf_set_var(bufnr, 'buffer_name', bufname)
  vim.api.nvim_chan_send(vim.api.nvim_get_option_value('channel', {buf = bufnr}), opt .. "\r")
end


local function next_line()
	local current_line = vim.api.nvim_win_get_cursor(0)[1]
	local total_lines = vim.api.nvim_buf_line_count(0)

	for i = current_line+1, total_lines do
		local line_content = vim.api.nvim_buf_get_lines(0, i-1, i, false)[1]
		if line_content:match('^%S') then
			vim.api.nvim_win_set_cursor(0, {i,0})
			break
		end
	end
end

function SendToRepl(opt, ...)
	--0: send the current line to REPL	
	--1: send the visual selection to REPL
	--2: send the entire file up to and including the current line to REPL
	--3: send text passed as optional args to REPL
	local txt = ''
	if opt == 1 then
		vim.cmd('normal! gv"xy') --captures vis selection
		txt = vim.fn.getreg('x')
	elseif opt == 2 then
		local ln, _  = unpack(vim.api.nvim_win_get_cursor(0))
		local lnTxts = vim.api.nvim_buf_get_lines(vim.api.nvim_get_current_buf(), 0, ln, false)
		txt = table.concat(lnTxts, "\n")
		-- txt = lnTxts
	elseif opt == 3 then
		if ... then
			for i, v in ipairs({...}) do
				txt = txt .. v
			end
		end
	else
		txt = vim.api.nvim_get_current_line()
	end

	-- move cursor to next non-whitespace, non-comment line
	next_line()	

	local term_buf = nil
	if vim.g.stata_repl ~= nil then
		term_buf = vim.g.stata_repl
	elseif vim.g.python_repl ~= nil then
		term_buf = vim.g.python_repl
	elseif vim.g.term_buf ~= nil then
		term_buf = vim.g.term_buf
	else
		for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
			if vim.bo[bufnr].buftype == 'terminal' then
				term_buf = bufnr
				break
			end
		end
	end

	if term_buf == nil then
		print("No terminal found.")
		return
	end
	if string.match(string.lower(txt), "%f[%a]use%f[%A]") then 
		vim.api.nvim_chan_send(vim.api.nvim_get_option_value('channel',{buf = term_buf}), txt .. '\r')
		vim.api.nvim_chan_send(vim.api.nvim_get_option_value('channel',{buf = term_buf}), "describe" .. '\r')
		-- vim.api.nvim_command("lua StataGlobalEnv()")
	else
		vim.api.nvim_chan_send(vim.api.nvim_get_option_value('channel', {buf = term_buf}), txt .. '\r')
	end
end
