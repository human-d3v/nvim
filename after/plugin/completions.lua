local cmp = require("cmp")
local lsp =	require('lsp-zero').preset({})

require("luasnip.loaders.from_vscode").lazy_load()

local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-y>'] = cmp.mapping.confirm({select = true}),
	["<C Space>"] = cmp.mapping.complete(),
})

cmp.setup({
  mapping = cmp_mappings,
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
		{ name = 'codeium'	},
    { name = 'luasnip' },
	}, 
	{
    { name = 'buffer' },
  }),
})
