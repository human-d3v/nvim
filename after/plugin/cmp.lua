
vim.opt.completeopt = {"menu", "menuone", "noselect"}
vim.opt.shortmess:append("c") -- set option to hide messages


--prettier icons in autocomplete
local lspkind = require('lspkind')
lspkind.init({})

local cmp = require("cmp")
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
		{name = 'path'},
		{name = 'luasnip'},
		-- {name = 'copilot'},
		-- {name = 'codeium'},
		{name = 'buffer'},
		{name = 'crates'},
		{name = 'nvim_lsp_signature_help'},
	})
})


local lua_snip = require('luasnip')
lua_snip.config.set_config({
	history = false,
	updateevents = "TextChanged,TextChangedI"
})

for _, ft_path in
	ipairs(vim.api.nvim_get_runtime_file('after/plugin/snippets/*.lua', true)) do
	loadfile(ft_path)()
end


-- ctrl + l to jump to next snippet location
vim.keymap.set({"i", "s"}, "<c-l>", function()
	if lua_snip.expand_or_jumpable() then
		lua_snip.expand_or_jump()
	end
end, {silent = true})

-- ctrl + h to jump to previous snippet location
vim.keymap.set({"i", "s"}, "<c-h>", function()
  if lua_snip.jumpable(-1) then
    lua_snip.jump(-1)
  end
end, {silent = true})
