function OpenBufferTerminalRepl(opt)

	--set global variable for code buffer
	vim.g.code_buf = vim.api.nvim_get_current_buf()

	--open term buf and move cursor there
	vim.api.nvim_exec2('belowright split | term', {output = true})
	local bufnr = vim.api.nvim_get_current_buf()

	-- set global variable based on repl type	
	if opt == 'stata-mp' then
		vim.g.stata_repl = bufnr
	elseif opt == 'py' then
		vim.g.python_repl = bufnr
	else
		vim.g.term_buf = bufnr
	end
  vim.api.nvim_chan_send(vim.api.nvim_get_option_value('channel', {buf = bufnr}), opt .. "\r")

	--move cursor to the last row in the term_buf
	vim.api.nvim_win_set_cursor(0, {vim.api.nvim_buf_line_count(bufnr),0})
	-- move cursor to code buffer
	vim.cmd('wincmd p')
end



function CloseBuffer(term)
	if term == 'stata' then
		if vim.g.stata_repl ~= nil then
			vim.api.nvim_buf_delete(vim.g.stata_repl, {force = true})
			vim.g.stata_repl = nil
		end
	elseif term == 'py' then
		if vim.g.python_repl ~= nil then
			vim.api.nvim_buf_delete(vim.g.python_repl, {force = true})
			vim.g.python_repl = nil
		end
	elseif term == 'term' then
		if vim.g.term_buf ~= nil then
			vim.api.nvim_buf_delete(vim.g.term_buf, {force = true})
			vim.g.term_buf = nil
		end
	else
		print("No terminal found")
		return
	end
end



function VerifyCloseBuffer(term)
	local answer = vim.fn.input('Are you sure you want to close the terminal? [y,n]  ')
	if answer == 'y' then
		CloseBuffer(term)
	else
		print('\nAction Cancelled.')
	end
end


---lazy load these functions bound to filetypes

vim.api.nvim_create_autocmd('Filetype', {
	pattern = {'python', 'stata'},
	callback = function()
		vim.schedule(function()
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



			function SendToRepl(repl_type, input_type, ...)
				-- repl_type
				-- 'stata'
				-- 'python'
				-- 'term'

				-- input_type
				--0: send the current line to REPL	
				--1: send the visual selection to REPL
				--2: send the entire file up to and including the current line to REPL
				--3: send text passed as optional args to REPL

				local txt = ''
				if input_type == 1 then
					vim.cmd('normal! gv"xy') --captures vis selection
					txt = vim.fn.getreg('x')
				elseif input_type == 2 then
					local ln, _  = unpack(vim.api.nvim_win_get_cursor(0))
					local lnTxts = vim.api.nvim_buf_get_lines(vim.api.nvim_get_current_buf(), 0, ln, false)
					txt = table.concat(lnTxts, "\n")
					-- txt = lnTxts
				elseif input_type == 3 then
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

				if repl_type == 'stata' then
					if vim.g.stata_repl ~= nil then
						term_buf = vim.g.stata_repl
					end
				elseif repl_type == 'python' then
					if vim.g.python_repl ~= nil then
						term_buf = vim.g.python_repl
					end
				elseif repl_type == 'term' then
					if vim.g.term_buf ~= nil then
						term_buf = vim.g.term_buf
					end
				else
					for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
						if vim.bo[bufnr].buftype == 'terminal' then
							term_buf = bufnr
							break
						end
					end
				end

				if term_buf == nil then
					local answer = vim.fn.input("No terminal found. Would you like to open one? \n'p' -- python\n's' -- stata\n't' -- terminal\n'n' -- cancel\n")
					if answer == 'p' then
						OpenBufferTerminalRepl('py')
						term_buf = vim.g.python_repl
					elseif answer == 's' then
						OpenBufferTerminalRepl('stata-mp')
						term_buf = vim.g.stata_repl
					elseif answer == 't' then
						OpenBufferTerminalRepl('')
						term_buf = vim.g.term_buf
					else
						print('\nAborted.')
						return
					end
				end

				vim.api.nvim_chan_send(vim.api.nvim_get_option_value('channel', {buf = term_buf}), txt .. '\r')
			end



			function VerifySendToRepl(repl_type, input_type, cmd)
				local answer = vim.fn.input('Are you sure you want to send "' .. cmd .. '"to the REPL? [y,n]  ')
				if answer:lower() == 'y' then 
					SendToRepl(repl_type, input_type, cmd)
				else
					print('Cancelled')
				end
			end



			function TempBuffer()
				if vim.g.term_buf == nil then
					print('No terminal found')
				end
				--get new buffer
				local bufnr = vim.api.nvim_create_buf(false,true)
				local winWidth = vim.api.nvim_win_get_width(0)
				-- local winHeight = vim.api.nvim_win_get_height(0)
				vim.api.nvim_set_option_value('filetype', 'bash', {buf=bufnr})


				--calculate floating window size
				local floatWidth = math.ceil(winWidth * 0.4)
				local floatHeight = math.ceil(winWidth * 0.02)
				--calculate starting pos
				local win = vim.api.nvim_get_current_win()
				local cursor = vim.api.nvim_win_get_cursor(win)
				local col = cursor[2] + 1
				local row = cursor[1] + 1
				--set opts
				local opts = {
					relative='editor',
					width= floatWidth,
					height= 1, -- floatHeight,
					col=col,
					row=row,
					style='minimal',
					border= {
						{"╭", "FloatBorder"},
						{"─", "FloatBorder"},
						{"╮", "FloatBorder"},
						{"│", "FloatBorder"},
						{"╯", "FloatBorder"},
						{"─", "FloatBorder"},
						{"╰", "FloatBorder"},
						{"│", "FloatBorder"}
					},
				}
				vim.cmd("highlight FloatBorder guifg=white")
				--create the floating window
				local floating_win = vim.api.nvim_open_win(bufnr, true, opts)
				vim.api.nvim_command('startinsert')

				local function execute_cmd()
					local cmd = vim.api.nvim_get_current_line()
					SendToRepl('term', 3, cmd)
					vim.api.nvim_command('stopinsert')
					vim.api.nvim_win_close(floating_win, true)
				end

				_G.execute_cmd = execute_cmd

				vim.api.nvim_buf_set_keymap(bufnr, 'i', '<CR>','<C-o>:lua execute_cmd()<CR>', 
				{noremap=true, silent=true})
			end
		end)
	end,
})
