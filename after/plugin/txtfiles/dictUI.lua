local function renderTitleSeparater(num)
	local sep = ''
	for i = 1, num, 1 do
		sep = sep .. '~'
	end
	return sep
end

function CreateFloatingWindow(wdObj)
	--get current buffer
	local bufnr = vim.api.nvim_create_buf(false,true)
	local winWidth = vim.api.nvim_win_get_width(0)
	local winHeight = vim.api.nvim_win_get_height(0)
	--calculate floating window size
	local floatWidth = math.ceil(winWidth * 0.2)
	local floatHeight = math.ceil(winWidth * 0.02)
	--calculate starting pos
	local col = math.ceil((winWidth-floatWidth)/2)
	local row = math.ceil((winHeight-floatHeight)/2)
	--set opts
	local opts = {
		relative='editor',
		width=floatWidth,
		height=floatHeight,
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
	local win = vim.api.nvim_open_win(bufnr, true, opts)
	--creat separator
	local sep = renderTitleSeparater(floatWidth)
	--set buffer contents
	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {wdObj.word, sep,
	wdObj.definition})
	--set buffer keymap to close window with 'q'
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'q','<cmd>bd!<CR>', {noremap=true,
		silent=true
	})
end

