-- For running ollama models locally and attaching them to the code buffer:

---- this dynamically assigns the model to the buffer if it's available on the computer
-- local function available_model_picker(preferred_models)
-- 	return function (self)
-- 		if self == nil then
-- 			-- Debug:render() calls Adapter.schema.model.default() but doesn't pass in 
-- 			--- `self`. Just return an empty string
-- 			return ''
-- 		end
--
-- 		local choices = self.schema.model.choices(self)
--
-- 		for _, best in ipairs(preferred_models) do
-- 			for choice, _ in ipairs(choices) do
-- 				if choice:find(best, 1, true) then
-- 					return choice
-- 				end
-- 			end
-- 		end
--
-- 		-- fallback to first available model
-- 		for choice, _ in pairs(choices) do
-- 			return choice
-- 		end
--
-- 		-- nothing found
-- 		return ''
-- 	end
-- end
--
-- require("codecompanion").setup({
-- 	strategies = {
-- 		chat = {
-- 			adapter = "ollama",
-- 			keymaps = {
-- 				close = {
-- 					modes = { n = "<Bslash>q", i = "<Bslash>q" },
-- 					opts = {}
-- 				}
-- 			}
-- 		},
-- 		inline = {
-- 			adapter = "ollama",
-- 		},
-- 	},
-- 	adapters = {
-- 		http = {
-- 			ollama = function ()
-- 				return require("codecompanion.adapters").extend("ollama", {
-- 					schema = {
-- 						model = {
-- 							default = available_model_picker(
-- 								{
-- 									-- "codestral:latest"
-- 									"deepseek-coder-v2"
-- 								}
-- 							)
-- 						}
-- 					}
-- 				})
-- 			end,
-- 		}
-- 	}
-- })

------------------------------------------------------------------------------
-- For using the copilot adapter provided by work account:
---- Set up zbirenbaum/copilot.lua
require('copilot').setup({
	suggestion = {enabled = false}, -- disable autocomplete
	panel = {enabled = false}
})

require("codecompanion").setup({
	strategies = {
		chat = {
			adapter = "copilot",
		},
		inline = {
			adapter = "copilot", 
		},
		agent = {
			adapter = "copilot",
		}
	},
})

-- Set keymaps
vim.schedule(function ()
	vim.api.nvim_set_keymap("n", "<Bslash>c", ":CodeCompanionChat<CR>", 
		{silent=true})
	vim.api.nvim_set_keymap("n", "<Bslash>q", ":CodeCompanion<CR>",
		{silent=true})
end)
