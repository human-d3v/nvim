local opts = {noremap = true, buffer = true, silent = true}

local activate_str = [[ [ -f "./bin/activate" ] && source ./bin/activate || [ -f "../bin/activate" ] && source ../bin/activate || [ -f "../../bin/activate" ] && source ../../bin/activate; py ]]
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.schedule(function()
			--python repl
			vim.keymap.set("n", "<leader><leader>py", ":lua OpenBufferTerminalRepl(".. activate_str .. ")<CR>" , opts)
			vim.keymap.set({"v","x"}, "<Bslash>d", [[:lua SendToRepl('python', 1)<CR>]], opts)
			vim.keymap.set("n", "<Bslash>d", [[:lua SendToRepl('python', 0)<CR>]], opts)
			vim.keymap.set("n", "<Bslash>aa", [[:lua SendToRepl('python', 2)<CR>]], opts)
			vim.keymap.set('n', '<Bslash>n', [[:lua SendToRepl('python', 3, "py")<CR>]], opts)
			vim.keymap.set('n', '<Bslash>rm', [[:lua VerifySendToRepl('python', 3, "exit()")<CR>]], opts)
			vim.keymap.set('n', '<Bslash>q', [[:lua VerifyCloseBuffer('python')<CR>]], opts)
			-- term commands
			vim.keymap.set('n', '<Bslash>t', [[:lua SendToRepl('term', 0)<CR>]], opts)
			vim.keymap.set({'v','x'}, '<Bslash>t', [[:lua SendToRepl('term', 1)<CR>]], opts)
			vim.keymap.set('n', '<leader>t', [[:lua TempBuffer()<CR>]], opts)
			vim.keymap.set('n', '<Bslash>tq', [[:lua CloseBuffer('term')<CR>]], opts)
		end)
	end,
})
