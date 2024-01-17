config = function ()
	require('tabout').setup {
		tabkey = '<Tab>',
		backwards_tabkey = '<S-Tab>',
		act_as_tab = true,
		act_as_shif_tab = false,
		default_tab = '<C-t>',
		default_shift_tab = '<C-d>',
		enable_backwards = true,
		completion = true,
		tabouts = {
			{open = "'", close = "'"},
		  {open = '"', close = '"'},
			{open = "`", close = "`"},
			{open = "(", close = ")"},
			{open = "[", close = "]"},
			{open = "{", close = "}"}
		},
		ignore_beginning = true,
		exlude = {}
	}
end
