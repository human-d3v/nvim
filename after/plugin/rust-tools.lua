local rt = require('rust-tools')
local mason_registry = require('mason-registry')

local codelldb = mason_registry.get_package("codelldb")
local extension_path = codelldb:get_install_path() .. "/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"
local lablldb_path = extension_path .. "lldb/lib/liblldb.dylib"

rt.setup({
	dap = {
		adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, 
			lablldb_path)
	},
	server = {
		capabilities = require("cmp_nvim_lsp").default_capabilities(),
		on_attach = function (_,buffnr)
			--hover actions
			vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, 
				{buffer = buffnr})
			vim.keymap.set("n", "<Leader>i", rt.code_action_group.code_action_group,
				{buffer = buffnr})
		end,
	},
	tools = {
		hover_actions = {
			auto_focus = true,
		},
	},
})
