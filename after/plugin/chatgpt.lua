-- local home = vim.fn.expand('$HOME')
-- local cmd = "gpg --decrypt /.lsp/chatgpt/credential.txt.gpg"
--
-- vim.keymap.set("n", "<leader><leader>test",function() print(cmd) end,{noremap = true, buffer = true})
local function getKey()
	local cmd = "gpg --decrypt ~/.lsp/chatgpt/credential.txt.gpg"
	local handle = io.popen(cmd)
	local result = handle:read("*a")
	handle:close()
	return result
end

local instructions = [[
	** Instructions **
	^^^^^^^^^^^^^^^^^^
	-> <Ctrl-Enter> -- to submit message
	-> <Ctrl-y> -- yank last answer
	-> <Ctrl-o> -- toggle settings window
	-> <Tab> -- cycle through windows
	-> <Ctrl-f> -- Cycle through modes (center, stick to right)
	-> <Ctrl-c> -- close chat window
	-> <Ctrl-u> -- scroll up chat window
	-> <Ctrl-d> -- scroll down chat window
	-> <Ctrl-k> -- yank code from last answer
	-> <Ctrl-n> -- start new session
	-> <Ctrl-d> -- draft message (without sending to server)
	-> <Ctrl-r> -- switch role (between user and assistant)
	-> <Ctrl-s> -- toggle system message window
	-> <Ctrl-i>[edit window] -- use response as input
	-> <Ctrl-d>[edit window] -- view differences between panes and use diff-mode cmds

]]

require('chatgpt').setup({
	 api_key_cmd = getKey,
	 chat = {
		welcome_message = instructions, 
	 }
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
		vim.schedule(function ()
			vim.api.nvim_buf_set_keymap(0, "n", "<leader>gpt", ":ChatGPT<CR>", {noremap = true, silent = true})
			vim.api.nvim_buf_set_keymap(0, "n", "<leader>opt", ":ChatGPTRun optimize_code<CR>", {noremap = true, silent = true})
			vim.api.nvim_buf_set_keymap(0, "n", "<leader>ex", ":ChatGPTRun explain_code<CR>", {noremap = true, silent = true})
		end)
  end
})
