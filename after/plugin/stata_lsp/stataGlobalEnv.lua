-- helper functions
local function tableToRegister(t, reg)
	local lines = {}
	for key,val in pairs(t) do
		table.insert(lines, tostring(key) .. ":" .. tostring(val))
	end
	vim.api.nvim_set_reg(reg, table.concat(lines, "\n"))
end


function CaptureDescribedVariables()
	-- first, find the terminal buffer & 
	-- use that buffer
	if vim.g.terminal_buffer then 
		-- list window id's and navigate to the terminal_buffer
		local win_ids = vim.api.nvim_list_wins()
		local current_win = vim.api.nvim_get_current_win()
		for _,win in ipairs(win_ids) do
			if vim.api.nvim_win_get_buf(win) == vim.g.terminal_buffer then 
				vim.api.nvim_set_current_win(win)
				break
			end
		end

		vim.api.nvim_command('?describe')
		-- 
		local startLine = vim.fn.line('.')
		local endLine = vim.fn.line('$')

		-- -- find the line with 'describe' and keep the that number
		local txt = vim.api.nvim_buf_get_lines(vim.g.terminal_buffer,
			startLine,
			endLine, true)
		-- -- navigate back to the original buffer
		-- vim.api.nvim_set_current_win(current_win)
		-- --load txt into a register
		tableToRegister(txt, "s")
		-- for key,value in ipairs(txt) do
		-- 	print(key,value)
		-- end
		-- tableToRegister(txt, "s")
	else
		print("No terminal buffer found")
	end
end


function StataGlobalEnv()
	-- vim.api.nvim_command('lua SendToRepl
	-- initialize describe grab
	CaptureDescribedVariables()
	-- get contents of s register
	local contents = vim.api.nvim_get_register("s")
	-- create a new empty buffer
	-- local buf = vim.api.nvim_create_buf(false, true)
	-- -- set lines of buffer to contents of register
	-- vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(contents, "\n")) 
	-- -- make it non-editable
	-- vim.api.nvim_buf_set_option(buf, "modifiable", false)
	-- --- grab height of current window
	-- local height = vim.api.nvim_win_get_height(0)
	-- -- create a new window for buffer
	-- vim.api.nvim_open_win(buf, true, {relative='editor',row=10,col=10,width=25,height=height})
	-- local bufnr = vim.api.nvim_get_current_buf()
	-- vim.g.stata_global_env_buf = bufnr
	for key,val in pairs(contents) do
		print(key,val)
	end
end
