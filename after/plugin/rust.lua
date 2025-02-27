-- add rust completion
vim.g.rustaceanvim ={
	tools = {},
	server = {
		on_attach = function(_, bufnr)
			--code actions
			vim.keymap.set('n','<leader>ca', function(_, bufnr)
				vim.cmd.RustLsp('codeAction') end,
				{buffer = bufnr, desc = 'Code Action'})
			--code debuggables
			vim.keymap.set('n', '<leader>dr', function(_, bufnr)
				vim.cmd.RustLsp('debuggables') end,
				{buffer = bufnr, desc = 'Debuggables'})
			end,
		default_settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
          loadOutDirsFromCheck = true,
          buildScripts = {
            enable = true,
          },
        },
        checkOnSave = {
          allFeatures = true,
          command = "clippy",
          extraArgs = {"--no-deps"},
        },
        procMacro = {
          enable = true,
          ignored = {
            ['async-trait'] = {'async_trait'},
            ['napi-derive'] = {'napi'},
            ['async-recursion'] = {'async_recursion'},
					},
				},
			},
		},
	},
}

local dap = require('dap')

dap.configurations.rust = {
  {
    name = "Launch",
    type = "gdb",
    request = "launch",
    program = function ()
    	return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
		cwd = "${workspaceFolder}",
  },
}
