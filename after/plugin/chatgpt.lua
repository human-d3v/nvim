-- local instructions = [[
-- 	** Instructions **
-- 	^^^^^^^^^^^^^^^^^^
-- 	-> <Ctrl-Enter> -- to submit message
-- 	-> <Ctrl-y> -- yank last answer
-- 	-> <Ctrl-o> -- toggle settings window
-- 	-> <Tab> -- cycle through windows
-- 	-> <Ctrl-f> -- Cycle through modes (center, stick to right)
-- 	-> <Ctrl-c> -- close chat window
-- 	-> <Ctrl-u> -- scroll up chat window
-- 	-> <Ctrl-d> -- scroll down chat window
-- 	-> <Ctrl-k> -- yank code from last answer
-- 	-> <Ctrl-n> -- start new session
-- 	-> <Ctrl-d> -- draft message (without sending to server)
-- 	-> <Ctrl-r> -- switch role (between user and assistant)
-- 	-> <Ctrl-s> -- toggle system message window
-- 	-> <Ctrl-i>[edit window] -- use response as input
-- 	-> <Ctrl-d>[edit window] -- view differences between panes and use diff-mode cmds
--
-- ]]
--
-- -- to use work's azure depoloyement
-- -- local config = {
-- -- 	api_host_cmd = 'echo -n ""',
-- -- 	api_key_cmd = 'echo $OPENAI_API_KEY',
-- -- 	api_type_cmd = 'echo azure',
-- -- 	azure_api_base_cmd = 'echo $OPENAI_API_BASE',
-- -- 	azure_api_engine_cmd = 'echo recognition-assistant', -- engine means deployement name (wtf?)
-- -- 	azure_api_version_cmd = 'echo 2024-02-15-preview',
-- -- 	chat = {
-- -- 		welcome_message = instructions,
-- -- 	}
-- -- }
--
--
--
-- -- require("chatgpt").setup(config)
--
-- --to use chatgpt credits
-- require('chatgpt').setup({
-- 	 api_key_cmd = 'echo $OPENAI_API_KEY',
-- 	 chat = {
-- 		welcome_message = instructions,
-- 	 }
-- })
--
--
-- vim.api.nvim_create_autocmd('BufEnter', {
--   pattern = '*',
--   callback = function()
-- 		 vim.schedule(function ()
-- 			vim.api.nvim_buf_set_keymap(0, "n", "<leader>gpt", ":ChatGPT<CR>", {noremap = true, silent = true})
-- 			vim.api.nvim_buf_set_keymap(0, "n", "<leader>opt", ":ChatGPTRun optimize_code<CR>", {noremap = true, silent = true})
-- 			vim.api.nvim_buf_set_keymap(0, "n", "<leader>ex", ":ChatGPTRun explain_code<CR>", {noremap = true, silent = true})
-- 		end)
--   end
-- })


-- this dynamically assigns the model to the buffer if it's available on the computer
local function available_model_picker(preferred_models)
	return function (self)
		if self == nil then
			-- Debug:render() calls Adapter.schema.model.default() but doesn't pass in 
			--- `self`. Just return an empty string
			return ''
		end

		local choices = self.schema.model.choices(self)

		for _, best in ipairs(preferred_models) do
			for choice, _ in ipairs(choices) do
				if choice:find(best, 1, true) then
					return choice
				end
			end
		end

		-- fallback to first available model
		for choice, _ in pairs(choices) do
			return choice
		end

		-- nothing found
		return ''
	end
end

require("codecompanion").setup({
	strategies = {
		chat = {
			adapter = "ollama",
			keymaps = {
				close = {
					modes = { n = "<Bslash>q", i = "<Bslash>q" },
					opts = {}
				}
			}
		},
		inline = {
			adapter = "ollama",
		},
	},
	adapters = {
		ollama = function ()
			return require("codecompanion.adapters").extend("ollama", {
				schema = {
					model = {
						default = available_model_picker(
							{
								-- "codestral:latest"
								"deepseek-coder-v2"
							}
						)
					}
				}
			})

		end
	}
})

vim.schedule(function ()
	vim.api.nvim_set_keymap("n", "<Bslash>c", ":CodeCompanionChat<CR>", 
		{silent=true})
	vim.api.nvim_set_keymap("n", "<Bslash>q", ":CodeCompanion<CR>",
		{silent=true})
end)
