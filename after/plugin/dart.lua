vim.api.nvim_create_autocmd("FileType", {
	pattern = {"dart"},
	callback = function()
		vim.schedule(function()
			vim.lsp.config.dartls = {
				cmd = {"dart", "language-server", "--protocol=lsp"},
			}
			local ftools = require("flutter-tools")
			ftools.debugger = {
				enabled = true,
				register_configurations = function ()
					require("dap").configurations.dart = {}
					require("dap.ext.vscode").load_launchjs()
				end,
			}
		end)
	end,
})
