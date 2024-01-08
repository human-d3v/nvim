local function renderTitleSeparater(num)
	local sep = ''
	for i = 1, num, 1 do
		sep = sep .. '~'
	end
	return sep
end

local function newLineRender(obj)
	local definitions = obj.definition
	local lines = {}
	for _, def in ipairs(definitions) do
		table.insert(lines, def)
	end
	return lines
end

function CreateFloatingWindow(wdObj,hdr)
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
	--create separator
	local sep = renderTitleSeparater(floatWidth)
	--create body contents
	local body = newLineRender(wdObj)
	--set buffer contents
	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {hdr, sep, wdObj.word, sep,
	unpack(body)})
	--set buffer keymap to close window with 'q'
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'q','<cmd>bd!<CR>', {noremap=true,
		silent=true
	})
end

