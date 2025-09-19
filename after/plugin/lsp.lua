require('mason').setup({})
require('mason-lspconfig').setup({
	handlers = {
		function (server_name)
			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			vim.lsp.config[server_name] = {
				capabilities = capabilities,
			}
		end
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function (args)
		local bufnr = args.buf
		local opts = {buffer = bufnr, remap = false}
		vim.keymap.set("n","gd",function() vim.lsp.buf.definition() end, opts) --go to definition
		vim.keymap.set('n','K',function() vim.lsp.buf.hover() end, opts) -- hover
		vim.keymap.set('n','<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts) --view workspace
		vim.keymap.set('n','<leader>vd', function() vim.diagnostic.open_float() end, opts) --view diagnostic
		vim.keymap.set('n','[d',function() vim.diagnostic.jump({count=1, float=true, severity = {min = vim.diagnostic.severity.HINT}}) end, opts)
		vim.keymap.set('n',']d',function() vim.diagnostic.jump({count=-1, float=true, severity = {min = vim.diagnostic.severity.HINT}}) end, opts)
		vim.keymap.set('n','<leader>vca', function() vim.lsp.buf.code_action() end, opts) --view code action
		vim.keymap.set('n','<leader>vrn', function() vim.lsp.buf.rename() end, opts) --rename variables
		vim.keymap.set('n','<leader>vrr', function() vim.lsp.buf.references() end, opts)
		vim.keymap.set('n','<leader>h', function() vim.lsp.buf.signature_help() end, opts)
		vim.keymap.set('n', '<leader>ch', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, opts)
		vim.keymap.set('n', '<C-y>', function() vim.diagnostic.open_float() end, opts)
	end
})


-- remove comment line on newline
local id = vim.api.nvim_create_augroup('GeneralLsp', {clear = true})

vim.api.nvim_create_autocmd("BufEnter", {
	callback= function()
		vim.opt.formatoptions:remove {"c", "r", "o"}
	end,
	group=id,
	desc = "Disable new line comment"
})

local dap = require('dap')
dap.adapters.gdb = {
	type = "executable",
	command = "gdb",
	args = {"-i","dap"}
}

--specific for lsp support for neovim configuration
--shoutout to @VonHeikemen
--local function nvim_workspace(opts)
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')
vim.lsp.config.lua_ls = {
	settings = {
		Lua = {
			--Disable telemetry
			telemetry = {enable = false},
			runtime = {
				--tell lsp which version of lua you're using 
				version = 'LuaJIT',
				path = runtime_path,
			},
			diagnostics = {
				globals = { 'vim'}
			},
			workspace = {
				checkThirdParty = false,

				library = {
				--make server aware of nvim runtime files
					vim.fn.expand('$VIMRUNTIME/lua'),
					vim.fn.stdpath('config') .. '/lua'
				}
			}
		}
	}
}

-- mason is launching a separate version of lua_ls on MacOS without the custom 
--   settings this will kill that server
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function ()
		for _, client in ipairs(vim.lsp.get_clients()) do
			if client.name == "lua_ls" and vim.tbl_isempty(client.config.settings or {}) then
				client.stop()
			end
		end
	end
})
