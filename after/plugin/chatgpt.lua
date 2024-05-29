-- local home = vim.fn.expand('$HOME')
-- local cmd = "gpg --decrypt /.lsp/chatgpt/credential.txt.gpg"
--
-- vim.keymap.set("n", "<leader><leader>test",function() print(cmd) end,{noremap = true, buffer = true})
local function getEnvVar(cmd)
	local handle = io.popen(cmd)
	local result = nil
	if handle then
	  result = handle:read("*a")
	end
 print(result)
end
local function getPersonalKey()
	local cmd = "gpg --decrypt ~/.lsp/chatgpt/credential.txt.gpg"
	return getEnvVar(cmd)
end

local function getWorkKey()
	local cmd = "echo $AZURE_OPENAI_KEY"
  return getEnvVar(cmd)
end

local function getBaseURL()
	local cmd = "echo $AZURE_OPENAI_ENDPOINT"
	print(getEnvVar(cmd))
end


-- local function getApiVersion()
-- 	local cmd = "echo $AZURE_OPENAI_API_VERSION"
-- 	return getEnvVar(cmd)
-- end

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

-- to use work's azure depoloyement
local config = {
	api_host_cmd = 'echo -n ""',
	api_key_cmd = 'echo $OPENAI_API_KEY',
	api_type_cmd = 'echo azure',
	azure_api_base_cmd = 'echo $OPENAI_API_BASE',
	azure_api_engine_cmd = 'echo recognition-assistant',
	azure_api_version_cmd = 'echo 2024-02-15-preview',
	chat = {
		welcome_message = instructions,
	}
}



require("chatgpt").setup(config)

-- to use chatgpt credits
-- require('chatgpt').setup({
-- 	 api_key_cmd = getPersonalKey,
-- 	 chat = {
-- 		welcome_message = instructions, 
-- 	 }
-- })


vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  callback = function()
		 vim.schedule(function ()
			vim.api.nvim_buf_set_keymap(0, "n", "<leader>gpt", ":ChatGPT<CR>", {noremap = true, silent = true})
			vim.api.nvim_buf_set_keymap(0, "n", "<leader>opt", ":ChatGPTRun optimize_code<CR>", {noremap = true, silent = true})
			vim.api.nvim_buf_set_keymap(0, "n", "<leader>ex", ":ChatGPTRun explain_code<CR>", {noremap = true, silent = true})
		end)
  end
})
