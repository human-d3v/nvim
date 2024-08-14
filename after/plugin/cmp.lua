local cmp = require("cmp")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered()
		-- documentation = cmp.config.window.bordered()
	},
	mapping = cmp.mapping.preset.insert({
		['<C-p>'] = cmp.mapping.select_prev_item({select = true}),
		['<C-n>'] = cmp.mapping.select_next_item({select = true}),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-y>'] = cmp.mapping.confirm({select = true}),
	}),
	sources = cmp.config.sources({
		{name = 'nvim_lsp'},
		{name = 'luasnip'},
		-- {name = 'copilot'},
		{name = 'codeium'},
	},{
		{name = 'buffer'},
		{name = 'crates'},
	})
})

