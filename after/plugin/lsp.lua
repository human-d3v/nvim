local lsp = require('lsp-zero').preset({})

lsp.preset("recommended")

lsp.ensure_installed({
	'rust_analyzer',
})
--fix undefined global vim
lsp.nvim_workspace();

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-y>'] = cmp.mapping.confirm({select = true}),
	["<C Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
	mapping = cmp_mappings
})

lsp.set_preferences({
	suggest_lsp_servers = false,
	sign_icons = { 
		error = "E",
		warm = "W",
		hint = "H",
		info = "I",
	}
})

--on attach is really cool functionality, each time I'm on a buffer, this snippet of code lives only for the live of the buffer session. 
--so if I navigate to something that doesn't have a buffer, I can still use these mapped values, but if there's no lsp, vim will do it's best to
--try to fulfill the request. 

lsp.on_attach(function(client,bufnr)
	local opts = {buffer = bufnr, remap = false}

	vim.keymap.set("n","gd",function() vim.lsp.buf.definition() end, opts) --go to definition
	vim.keymap.set('n','K',function() vim.lsp.buf.hover() end, opts) 
	vim.keymap.set('n','<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts) --view workspace
	vim.keymap.set('n','<leader>vd', function() vim.diagnostic.open_foat() end, opts)
	vim.keymap.set('n','[d',function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set('n',']d',function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set('n','<leader>vca', function() vim.lsp.buf.code_action() end, opts) --view code action
	vim.keymap.set('n','<leader>vrn', function() vim.lsp.buf.rename() end, opts) --rename variables
	vim.keymap.set('n','<leader>vrr', function() vim.lsp.buf.references() end, opts)
	vim.keymap.set('i','<C-h>', function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()

vim.diagnostic.config({
	virtual_text=true
})
